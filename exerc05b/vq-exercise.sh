# Adjust these as convenient:
export P=20
export e=0.0005

# get the class names:
classes=$(xsv select class tt-list.csv | uniq | rg -v class | sort)

function duration_string() {
  pfx=$1
  dur=$2
  echo "$pfx  (took: $((dur / 60))mins:$((dur % 60))secs)"
}

train_start=$SECONDS
echo "TRAINING..."

# (Note: not using `parallel` as `vq learn` already takes advantage of available cores)
echo "$classes" | while read -r class; do
  ecoz2 vq learn --prediction-order=${P} --epsilon=${e} --class-name={} --predictors tt-list.csv &
done
wait
train_end=$SECONDS
train_duration=$((train_end - train_start))
echo
duration_string "**TRAINING COMPLETED**" $train_duration
echo " P=$P  e=$e"

test_start=$SECONDS
echo
echo "CLASSIFYING TRAINING PREDICTORS"
cmd="ecoz2 vq classify --codebooks data/codebooks/[A-Z]*/eps_${e}_M_1024.cbook --predictors tt-list.csv --tt=TRAIN"
echo "$cmd"
$cmd

echo
echo "CLASSIFYING TEST PREDICTORS"
cmd="ecoz2 vq classify --codebooks data/codebooks/[A-Z]*/eps_${e}_M_1024.cbook --predictors tt-list.csv --tt=TEST"
echo "$cmd"
$cmd

test_end=$SECONDS
test_duration=$((test_end - test_start))

echo
duration_string "**CLASSIFICATION COMPLETED**" $test_duration
echo " P=$P  e=$e"
