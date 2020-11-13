#!/usr/bin/bash
set -ue

P=$1
M=$2
O=$3
work_dir=$4

sequences_dir="${work_dir}/sequences"
mchains_dir="${work_dir}/mchains"

mkdir -p ${mchains_dir}

for class in A Bm C E F G2 I3 II; do
  echo "training class=${class}"
  sequences=${sequences_dir}/TRAIN_sequences_$class.pickle
  mchain_train.py \
      -O=${O} \
      -M=${M} \
      --sequences-filename=${sequences} \
      --class-name=$class \
      --dest-dir=${mchains_dir}
done
