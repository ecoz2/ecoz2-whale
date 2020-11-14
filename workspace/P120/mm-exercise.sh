set -ue

PATH="$HOME/.local/bin:$PATH"
PATH="$HOME/.cargo/bin:$PATH"

function main() {
  main_start=$SECONDS

  for M in 512 1024 2048 4096; do
    one_exercise ${M}
  done

  main_end=$SECONDS
  main_duration=$((main_end - main_start))
  echo
  duration_string "==DONE MAIN==" $main_duration
}

function one_exercise() {
  M=$1

  echo "-- mm-exercise.sh --"
  echo "  M = $M (== N)"
  echo

  train_start=$SECONDS
  echo "TRAINING..."

  # In parallel, using all cores available:
  ls data/sequences/M${M} | \
    parallel --results results "ecoz2 mm learn -M=${M} --class-name={} ../tt-list.csv"

  train_end=$SECONDS
  train_duration=$((train_end - train_start))
  echo
  duration_string "**TRAINING COMPLETED**" $train_duration
  echo "** M=$M  (== N)"
  echo

  # set as convenient:
  #SHOW_RANKED=--show-ranked
  SHOW_RANKED=

  test_start=$SECONDS
  echo
  echo "CLASSIFYING TRAINING SEQUENCES"
  cmd="ecoz2 mm classify ${SHOW_RANKED} --models data/mms/M${M} -M=${M} --tt=TRAIN --sequences ../tt-list.csv"
  echo "$cmd"
  $cmd

  train_accuracy=$(    cat mm_${M}_classification.json | jq .accuracy)
  train_avg_accuracy=$(cat mm_${M}_classification.json | jq .avg_accuracy)

  echo
  echo "CLASSIFYING TEST SEQUENCES"
  cmd="ecoz2 mm classify ${SHOW_RANKED} --models data/mms/M${M} -M=${M} --tt=TEST --sequences ../tt-list.csv"
  echo "$cmd"
  $cmd

  ../../exerc06/confusion.py --source mm_${M}_y_true_pred.json
  echo "  M = $M\n"  # to easily spot/associate with the MCC result above

  test_accuracy=$(    cat mm_${M}_classification.json | jq .accuracy)
  test_avg_accuracy=$(cat mm_${M}_classification.json | jq .avg_accuracy)

  test_end=$SECONDS
  test_duration=$((test_end - test_start))

  echo
  duration_string "**CLASSIFICATION COMPLETED**" $test_duration
  echo " M=$M  (== N)"
  echo " train_avg_accuracy: $train_avg_accuracy%"
  echo "  test_avg_accuracy: $test_avg_accuracy%"
  echo
  summary_line="$M, $train_accuracy, $train_avg_accuracy, $test_accuracy, $test_avg_accuracy"
  if [ ! -f mm-summary.csv ]; then
    echo "M,Train Ac,Train avgAc,Test Ac,Test avgAc" > mm-summary.csv
  fi
  echo "$summary_line" >> mm-summary.csv
  echo
}

function duration_string() {
  pfx=$1
  dur=$2
  echo "$pfx  (took: $((dur / 60))mins:$((dur % 60))secs)"
}

main
