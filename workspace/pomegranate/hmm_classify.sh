#!/usr/bin/bash
set -ue

P=$1
M=$2
N=$3
work_dir=$4

sequences_dir="${work_dir}/sequences"
hmms_dir="${work_dir}/hmms"

hmm_classify.py \
    --models ${hmms_dir}/N${N}_*_hmm.json \
    --sequences-filenames ${sequences_dir}/TEST_sequences_*.pickle
    # --verbose
