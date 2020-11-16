set -ue

PATH="$HOME/.cargo/bin:$PATH"


# Adjust these as convenient:
export P=160
export e=0.0005

# xsv: https://github.com/BurntSushi/xsv
# rg: https://github.com/BurntSushi/ripgrep


echo "P=${P} generating LPC predictors"
W=45
O=15
for tt in TRAIN TEST; do
  echo "tt=${tt}"
  ecoz2 lpc -P ${P} -W ${W} -O ${O} \
      --signals ../tt-list.csv \
      --signals-dir-template ../data/signals/{class}/{selection}.wav \
      --tt=${tt}
done


# get the class names:
classes=$(xsv select class ../tt-list.csv | uniq | rg -v class | sort)
echo "classes = ${classes}"

function duration_string() {
  pfx=$1
  dur=$2
  echo "$pfx  (took: $((dur / 60))mins:$((dur % 60))secs)"
}

train_start=$SECONDS
echo "TRAINING..."

# (note: `vq learn` takes advantage of available cores)
# The following generates all codebooks for M = 2, 4, ..., 4096:
echo "$classes" | while read class; do
 ecoz2 vq learn --prediction-order=${P} \
                --epsilon=${e} \
                --class-name=${class} \
                --predictors ../tt-list.csv
done
train_end=$SECONDS
train_duration=$((train_end - train_start))
echo
duration_string "**TRAINING COMPLETED**" $train_duration
echo " P=$P  e=$e"

test_start=$SECONDS
echo "CLASSIFYING..."

for M in 0002 0004 0008 0016 0032 0064 0128 0256 0512 1024 2048 4096; do
  # echo
  # echo "CLASSIFYING TRAINING PREDICTORS"
  # cmd="ecoz2 vq classify --codebooks data/codebooks/[A-Z]*/eps_${e}_M_1024.cbook --predictors ../tt-list.csv --tt=TRAIN"
  # echo "$cmd"
  # $cmd

  echo
  echo "CLASSIFYING TEST PREDICTORS M=${M}"
  cmd="ecoz2 vq classify --codebooks data/codebooks/[A-Z]*/eps_${e}_M_${M}.cbook --predictors ../tt-list.csv --tt=TEST"
  echo "$cmd"
  $cmd
  echo "DONE CLASSIFYING TEST PREDICTORS M=${M}"
done

test_end=$SECONDS
test_duration=$((test_end - test_start))

echo
duration_string "**CLASSIFICATION COMPLETED**" $test_duration
echo " P=$P  e=$e"
