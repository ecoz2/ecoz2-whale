function main() {
  main_start=$SECONDS

  for N in $(seq 1 20); do
    for M in 512 1024 2048; do
      for A in 0.3; do
        for I in 0 1 2 5 10; do
          one_exercise ${N} ${M} ${A} ${I}
        done
      done
    done
  done
  #one_exercise 3 2048 0.3 2

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

  Aparam="-a=${a}"
  if [ "$I" ] && [ "$I" != "-1" ]; then
    Iparam="-I=$I"
    Iname="_I$I"
  fi

  echo "-- hmm-exercise.sh --"
  echo "  N = $N  M = $M  a = $a  I = $I"
  echo

  train_start=$SECONDS
  echo "TRAINING..."

  # In parallel, using all cores available:
  ls data/sequences/TRAIN/M${M} | \
    parallel --results results "ecoz2 hmm learn -N=${N} ${Aparam} ${Iparam} data/sequences/TRAIN/M${M}/{}"

  # If sequentially:
  #for class in `ls data/sequences/TRAIN/M${M}/`; do
  #  ecoz2 hmm learn -N=${N} $Aparam $Iparam data/sequences/TRAIN/M${M}/${class} &
  #done
  #wait

  train_end=$SECONDS
  train_duration=$((train_end - train_start))
  echo
  duration_string "**TRAINING COMPLETED**" $train_duration
  echo " N=$N  M=$M  a=$a  I=$I"

  test_start=$SECONDS
  echo
  echo "CLASSIFYING TRAINING SEQUENCES"
  cmd="ecoz2 hmm classify --models data/hmms/N${N}__M${M}_t3__a${a}${Iname} --sequences data/sequences/TRAIN/M${M}"
  echo "$cmd"
  $cmd

  train_accuracy=$(cat classification.json | jq .accuracy)
  train_avg_accuracy=$(cat classification.json | jq .avg_accuracy)

  echo
  echo "CLASSIFYING TEST SEQUENCES"
  cmd="ecoz2 hmm classify --models data/hmms/N${N}__M${M}_t3__a${a}${Iname} --sequences data/sequences/TEST/M${M}"
  echo "$cmd"
  $cmd

  test_accuracy=$(cat classification.json | jq .accuracy)
  test_avg_accuracy=$(cat classification.json | jq .avg_accuracy)

  test_end=$SECONDS
  test_duration=$((test_end - test_start))

  echo
  duration_string "**CLASSIFICATION COMPLETED**" $test_duration
  echo " N=$N  M=$M  a=$a  I=$I"
  echo " train_avg_accuracy: $train_avg_accuracy%"
  echo "  test_avg_accuracy: $test_avg_accuracy%"
  echo
  summary_line="$N, $M, $a, $I, $train_accuracy, $train_avg_accuracy, $test_accuracy, $test_avg_accuracy"
  echo $summary_line >> summary.csv
  echo
}

main
