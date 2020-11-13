set -ue

P=$1
M=$2
O=$3

dest_dir="P${P}/M${M}"

PATH="$HOME/.local/bin:$PATH"

# for `run-pom.sh`:
export POME_EXPLORATION_DIR=/Users/carueda/github/ecoz2/pomegranate-exploration
PATH="$POME_EXPLORATION_DIR:$PATH"


function generate_pickle_sequences() {
  my_dir=`pwd`

  out_dir_sequences="${dest_dir}/sequences"
  mkdir -p ${out_dir_sequences}

  cd ../P${P}

  for tt in TRAIN TEST; do
    for class in A Bm C E F G2 I3 II; do
      pickle="${my_dir}/${out_dir_sequences}/${tt}_sequences_$class.pickle"
      # echo "pickle=${pickle}"
      ecoz2 seq show --pickle ${pickle} --class-name=$class \
            --codebook-size=${M} --tt=${tt} ../tt-list.csv
    done
  done

  cd ${my_dir}
}

function train() {
  echo "TRAINING"
  work_dir=${dest_dir}
  run-pom.sh ./mchain_train.sh ${P} ${M} ${O} ${work_dir}
}

function classify() {
  echo "CLASSIFYING"
  work_dir=${dest_dir}
  run-pom.sh ./mchain_classify.sh ${P} ${M} ${O} ${work_dir}
}

function main() {
  generate_pickle_sequences
  train
  classify
}

main
