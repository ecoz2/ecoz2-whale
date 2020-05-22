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
  echo "-- nb-exercise.sh --"
  echo "  M = $M"
  echo

  train_start=$SECONDS
  echo "TRAINING..."

  # If using `parallel`:
  ls data/sequences/M${M} | \
    parallel --results results "ecoz2 nbayes learn -M=${M} --class-name={} --sequences tt-list.csv"

#  # Otherwise:
#  for class in `ls data/sequences/M${M}/`; do
#    CMD="ecoz2 nbayes learn -M=${M} --class-name=${class} --sequences tt-list.csv"
#    echo "running: ${CMD}"
#    ${CMD} &
#  done
#  wait

  train_end=$SECONDS
  train_duration=$((train_end - train_start))
  echo
  duration_string "**TRAINING COMPLETED**" $train_duration
  echo " M=$M"

  test_start=$SECONDS
  echo
  echo "CLASSIFYING TRAINING SEQUENCES"
  cmd="ecoz2 nbayes classify --models data/nbs/M${M} -M=${M} --tt=TRAIN --sequences tt-list.csv"
  echo "$cmd"
  $cmd

  train_accuracy=$(cat nb-classification.json | jq .accuracy)
  train_avg_accuracy=$(cat nb-classification.json | jq .avg_accuracy)

  echo
  echo "CLASSIFYING TEST SEQUENCES"
  cmd="ecoz2 nbayes classify --models data/nbs/M${M} -M=${M} --tt=TEST --sequences tt-list.csv"
  echo "$cmd"
  $cmd

  test_accuracy=$(cat nb-classification.json | jq .accuracy)
  test_avg_accuracy=$(cat nb-classification.json | jq .avg_accuracy)

  test_end=$SECONDS
  test_duration=$((test_end - test_start))

  echo
  duration_string "**CLASSIFICATION COMPLETED**" $test_duration
  echo " M=$M"
  echo " train_avg_accuracy: $train_avg_accuracy%"
  echo "  test_avg_accuracy: $test_avg_accuracy%"
  echo
  summary_line="$M, $train_accuracy, $train_avg_accuracy, $test_accuracy, $test_avg_accuracy"
  echo $summary_line >> nb-summary.csv
  echo
}

main
