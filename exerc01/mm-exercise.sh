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

function duration_string() {
  pfx=$1
  dur=$2
  echo "$pfx  (took: $((dur / 60))mins:$((dur % 60))secs)"
}

function one_exercise() {
  M=$1

  echo "-- mm-exercise.sh --"
  echo "  M = $M (== N)"
  echo

  train_start=$SECONDS
  echo "TRAINING..."

  # In parallel, using all cores available:
  ls data/sequences/TRAIN/M${M} | \
    parallel --results results "ecoz2 mm learn data/sequences/TRAIN/M${M}/{}"

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
  cmd="ecoz2 mm classify ${SHOW_RANKED} --models data/mms/M${M} --sequences data/sequences/TRAIN/M${M}"
  echo "$cmd"
  $cmd

  train_accuracy=$(cat mm-classification.json | jq .accuracy)
  train_avg_accuracy=$(cat mm-classification.json | jq .avg_accuracy)

  echo
  echo "CLASSIFYING TEST SEQUENCES"
  cmd="ecoz2 mm classify ${SHOW_RANKED} --models data/mms/M${M} --sequences data/sequences/TEST/M${M}"
  echo "$cmd"
  $cmd

  test_accuracy=$(cat mm-classification.json | jq .accuracy)
  test_avg_accuracy=$(cat mm-classification.json | jq .avg_accuracy)

  test_end=$SECONDS
  test_duration=$((test_end - test_start))

  echo
  duration_string "**CLASSIFICATION COMPLETED**" $test_duration
  echo " M=$M  (== N)"
  echo " train_avg_accuracy: $train_avg_accuracy%"
  echo "  test_avg_accuracy: $test_avg_accuracy%"
  echo
  summary_line="$M, $train_accuracy, $train_avg_accuracy, $test_accuracy, $test_avg_accuracy"
  echo $summary_line >> mm-summary.csv
  echo
}

main
