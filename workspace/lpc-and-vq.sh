set -ue

PATH="$HOME/.local/bin:$PATH"
PATH="$HOME/.cargo/bin:$PATH"

## extract signal segments (an one-off step):
# export echo $M=/u/carueda/soundscape/workspace/source_data/MARS_20161221_000046_SongSession_16kHz_HPF5Hz.wav
# export SOURCE_SEG=/u/carueda/soundscape/workspace/source_data/labels_with_I_and_I2_merged_into_II.csv
# ecoz2 sgn extract -m 200 \
#      --segments ${SOURCE_SEG} \
#      --wav ${SOURCE_WAV} \
#      --out-dir data/signals

function main() {
  main_start=$SECONDS

  for P in 45; do
    mkdir -p "P${P}"
    cd       "P${P}"
    run ${P} 45 15
    cd ..
  done

  main_end=$SECONDS
  main_duration=$((main_end - main_start))
  echo
  duration_string "==DONE MAIN==" $main_duration
}

function run() {
  P=$1
  W=$2
  O=$3
  echo "-- lpc-and-vq.sh --"
  echo "  P = $P  W = $W  O = $O"
  echo

  ## ------
  echo "P=${P} generating LPC predictors"
  ecoz2 lpc -P ${P} -W ${W} -O ${O} -m 200 ../data/signals

  ## ------
  ## TODO: the "split" should be on the signal segments!
  echo "P=${P} generating TRAIN and TEST predictor lists"
  echo "tt,class,selection" > tt-list.csv
  for class in `ls data/predictors/`; do
    ecoz2 util split --train-fraction 0.8 --file-ext .prd --files data/predictors/${class} >> tt-list.csv
  done
  echo "train instances: `grep TRAIN tt-list.csv| wc -l`"
  echo  "test instances: `grep TEST tt-list.csv| wc -l`"

  ## ------
  echo "P=${P} CODEBOOK GENERATION:"
  ecoz2 vq learn --prediction-order ${P} --epsilon 0.0005 --predictors tt-list.csv

  ## ------
  echo "P=${P} VECTOR QUANTIZATION:"
  for M in 0016 0032 0064 0128 0256 0512 1024 2048 4096; do
    echo $M
  done | parallel "ecoz2 vq quantize --codebook data/codebooks/_/eps_0.0005_M_{}.cbook data/predictors"
}

function duration_string() {
  pfx=$1
  dur=$2
  echo "$pfx  (took: $((dur / 60))mins:$((dur % 60))secs)"
}

main
