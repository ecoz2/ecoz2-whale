#!/usr/bin/bash
set -ue

P=$1
M=$2
O=$3
work_dir=$4

sequences_dir="${work_dir}/sequences"
mchains_dir="${work_dir}/mchains"

mchain_classify.py \
    --models ${mchains_dir}/class_*_order_${O}_mchain.json \
    --sequences-filenames ${sequences_dir}/TEST_sequences_*.pickle
    # --verbose
