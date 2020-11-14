set -ue

PATH="$HOME/.local/bin:$PATH"
PATH="$HOME/.cargo/bin:$PATH"

function main() {
  main_start=$SECONDS

  # model type
  t=0

  for N in 1 2 3 5 8 10 12 14 17 20 25 30; do
    for M in 2048 4096; do
      for A in 0; do
        # for I in $(seq 0 10); do
        for I in 0 1 5 10; do
          one_exercise ${N} ${M} ${A} ${I} ${t}
        done
      done
    done
  done
#  one_exercise 3 2048 0 1
  main_end=$SECONDS
  main_duration=$((main_end - main_start))
  echo
  duration_string "==DONE MAIN==" $main_duration
}

function duration_string() {
  pfx=$1
  dur=$2
  echo "$pfx  (took: $((dur / 60))mins:$((dur % 60))secs)"
}

function one_exercise() {
  N=$1
  M=$2
  a=$3
  I=$4
  t=$5

  Aparam="-a=${a}"
  if [ "$I" ] && [ "$I" != "-1" ]; then
    Iparam="-I=$I"
    Iname="_I$I"
  fi

  echo "-- hmm-exercise.sh --"
  echo "  N = $N  M = $M  a = $a  I = $I  t = $t"
  echo

  train_start=$SECONDS
  echo "TRAINING..."

  # In parallel, using all cores available:
  ls data/sequences/M${M} | \
    parallel "ecoz2 hmm learn -t=${t} -N=${N} -M=${M} ${Aparam} ${Iparam} --class-name={} --sequences ../tt-list.csv"

  train_end=$SECONDS
  train_duration=$((train_end - train_start))
  echo
  duration_string "**TRAINING COMPLETED**" $train_duration
  echo " N=$N  M=$M  a=$a  I=$I  t=$t"

  # set as convenient:
  #SHOW_RANKED=--show-ranked
  SHOW_RANKED=

  test_start=$SECONDS
  echo
  echo "CLASSIFYING TRAINING SEQUENCES"
  #mkdir -p c12n/TEST
  #c12n="--c12n c12n/TRAIN/N${N}__M${M}_t${t}__a${a}${Iname}.csv"
  c12n=""
  cmd="ecoz2 hmm classify ${SHOW_RANKED} ${c12n} --models data/hmms/N${N}__M${M}_t${t}__a${a}${Iname} -M=${M} --tt=TRAIN --sequences ../tt-list.csv"
  echo "$cmd"
  $cmd

  train_accuracy=$(    cat classification.json | jq .accuracy)
  train_avg_accuracy=$(cat classification.json | jq .avg_accuracy)

  echo
  echo "CLASSIFYING TEST SEQUENCES"
  mkdir -p c12n/TEST
  c12n="--c12n c12n/TEST/N${N}__M${M}_t${t}__a${a}${Iname}.csv"
  cmd="ecoz2 hmm classify ${SHOW_RANKED} ${c12n} --models data/hmms/N${N}__M${M}_t${t}__a${a}${Iname} -M=${M} --tt=TEST --sequences ../tt-list.csv"
  echo "$cmd"
  $cmd

  ../../exerc06/confusion.py --source c12n/TEST/N${N}__M${M}_t${t}__a${a}${Iname}.csv
  echo "  N=$N  M=$M  a=$a  I=$I  t=$t"

  test_accuracy=$(    cat classification.json | jq .accuracy)
  test_avg_accuracy=$(cat classification.json | jq .avg_accuracy)

  test_end=$SECONDS
  test_duration=$((test_end - test_start))

  echo
  duration_string "**CLASSIFICATION COMPLETED**" $test_duration
  echo " N=$N  M=$M  a=$a  I=$I  t=$t"
  echo " train_avg_accuracy: $train_avg_accuracy%"
  echo "  test_avg_accuracy: $test_avg_accuracy%"
  echo
  summary_line="$N, $M, $a, $I, $train_accuracy, $train_avg_accuracy, $test_accuracy, $test_avg_accuracy"
  if [ ! -f hmm-summary-t0.csv ]; then
    echo "N,M,a,I,Train Ac,Train avgAc,Test Ac,Test avgAc" > hmm-summary-t0.csv
  fi
  echo "$summary_line" >> hmm-summary-t0.csv
  echo
}

main
