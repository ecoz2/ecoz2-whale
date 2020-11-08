#!/usr/bin/bash
set -ue

P=$1
M=$2
N=$3
work_dir=$4

sequences_dir="${work_dir}/sequences"
hmms_dir="${work_dir}/hmms"

mkdir -p ${hmms_dir}

for class in A Bm C E F G2 I3 II; do
  sequences=${sequences_dir}/TRAIN_sequences_$class.pickle
  hmm_train.py \
      -N=${N} -M=${M} \
      --sequences-filename=${sequences} \
      --class-name=$class \
      --dest-dir=${hmms_dir}
done
