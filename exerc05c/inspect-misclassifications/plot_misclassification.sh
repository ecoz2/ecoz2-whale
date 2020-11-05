set -ue

for_class=$1
selection_number=$2
classified_as=$3

signal=../../MARS_20161221_000046_SongSession_16kHz_HPF5Hz.wav
segments=../../exerc01/MARS_20161221_000046_SongSession_16kHz_HPF5HzNorm_labels.csv


title="'${for_class}' #${selection_number} misclassified as '${classified_as}'"
out_name="instance_${for_class}_${selection_number}_misclassified_as_${classified_as}"
out_prefix="./"

sgn.plot.spec.py \
    --signal ${signal} \
    --segments ${segments} \
    --selection ${selection_number} \
    --window-size 1024 \
    --window-offset 32 \
    --lpc 20 \
    --lpc-window-size 1024 \
    --lpc-window-offset 32 \
    --lpc-num-points-per-window 256 \
    --no-plot \
    --title "${title}" \
    --out-prefix="${out_prefix}" \
    --out-name="${out_name}"
