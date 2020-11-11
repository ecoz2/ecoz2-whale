set -ue

PATH="$HOME/.local/bin:$PATH"

## extract signal segments (an one-off step):
# export echo $M=/u/carueda/soundscape/workspace/source_data/MARS_20161221_000046_SongSession_16kHz_HPF5Hz.wav
# export SOURCE_SEG=/u/carueda/soundscape/workspace/source_data/labels_with_I_and_I2_merged_into_II.csv
# ecoz2 sgn extract -m 200 \
#      --segments ${SOURCE_SEG} \
#      --wav ${SOURCE_WAV} \
#      --out-dir data/signals

function main() {
  main_start=$SECONDS

  W=45
  O=15

  for P in 160; do
    mkdir -p "P${P}"
    cd       "P${P}"

    ## ------
    echo "P=${P} generating LPC predictors"
    for tt in TRAIN TEST; do
      echo "tt=${tt}"
      ecoz2 lpc -P ${P} -W ${W} -O ${O} \
          --signals ../tt-list.csv \
          --signals-dir-template ../data/signals/{class}/{selection}.wav \
          --tt=${tt}
    done

    ## ------
    echo "P=${P} CODEBOOK GENERATION:"
    ecoz2 vq learn --prediction-order ${P} --epsilon 0.0005 --predictors ../tt-list.csv

    ## ------
    echo "P=${P} VECTOR QUANTIZATION:"
    # for M in 0016 0032 0064 0128 0256 0512 1024 2048 4096; do
    for M in 0512 1024 2048 4096; do
      echo $M
    done | parallel "ecoz2 vq quantize --codebook data/codebooks/_/eps_0.0005_M_{}.cbook data/predictors"

    ## ------
    echo "P=${P} TRAINING/CLASSIFICATION:"
    # for M in 32 64 128 256 512 1024 2048 4096; do
    for M in 512 1024 2048 4096; do
      one_exercise ${P} ${W} ${O} ${M}
    done
    cd ..
  done

  main_end=$SECONDS
  main_duration=$((main_end - main_start))
  echo
  duration_string "==DONE MAIN==" $main_duration
}

function one_exercise() {
  P=$1
  W=$2
  O=$3
  M=$4
  echo "-- nb-exercise.sh --"
  echo "  P = $P  M = $M"
  echo

  echo "P=${P} TRAINING..."

  train_start=$SECONDS

  ## If using `gnu parallel`:
  ls data/sequences/M${M} | \
    parallel "ecoz2 nb learn -M=${M} --class-name={} ../tt-list.csv"

  ## Otherwise:
  # for class in `ls data/sequences/M${M}/`; do
  #   CMD="ecoz2 nb learn -M=${M} --class-name=${class} ../tt-list.csv"
  #   echo "running: ${CMD}"
  #   ${CMD} &
  # done
  # wait

  train_end=$SECONDS
  train_duration=$((train_end - train_start))
  echo
  duration_string "** P=${P} TRAINING COMPLETED **" $train_duration
  echo " M=$M"

  test_start=$SECONDS
  echo
  echo "P=${P} CLASSIFYING TRAINING SEQUENCES"
  cmd="ecoz2 nb classify --models data/nbs/M${M} -M=${M} --tt=TRAIN --sequences ../tt-list.csv"
  echo "$cmd"
  $cmd

  train_accuracy=$(cat nb-classification.json | jq .accuracy)
  train_avg_accuracy=$(cat nb-classification.json | jq .avg_accuracy)

  echo
  echo "P=${P} CLASSIFYING TEST SEQUENCES"
  cmd="ecoz2 nb classify --models data/nbs/M${M} -M=${M} --tt=TEST --sequences ../tt-list.csv"
  echo "$cmd"
  $cmd

  test_accuracy=$(cat nb-classification.json | jq .accuracy)
  test_avg_accuracy=$(cat nb-classification.json | jq .avg_accuracy)

  test_end=$SECONDS
  test_duration=$((test_end - test_start))

  echo
  duration_string "** P=${P} CLASSIFICATION COMPLETED **" $test_duration
  echo " M=$M"
  echo " train_avg_accuracy: $train_avg_accuracy%"
  echo "  test_avg_accuracy: $test_avg_accuracy%"
  echo
  summary_line="$P, $M, $train_accuracy, $train_avg_accuracy, $test_accuracy, $test_avg_accuracy"
  if [ ! -f ../nb-summary.csv ]; then
    echo "P,M,Train Ac,Train avgAc,Test Ac,Test avgAc" > ../nb-summary.csv
  fi
  echo "$summary_line" >> ../nb-summary.csv
  echo
}

function duration_string() {
  pfx=$1
  dur=$2
  echo "$pfx  (took: $((dur / 60))mins:$((dur % 60))secs)"
}

main
