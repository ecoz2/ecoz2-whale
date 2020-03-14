# This ad hoc script is a helper to run all the main steps
# in the exercise.

# Adjust the following environment variable settings depending on
# where you have the ecoz2 executable and the source WAV file:
export PATH=../../ecoz2rs/target/release:$PATH
export SOURCE_WAV=~/Downloads/MARS_20161221_000046_SongSession_16kHz_HPF5Hz/MARS_20161221_000046_SongSession_16kHz_HPF5Hz.wav


## Extract signals:

ecoz2 sgn extract --segments MARS_20161221_000046_SongSession_16kHz_HPF5HzNorm_labels.csv \
                  --wav ${SOURCE_WAV} \
                  --out-dir data/signals

## Remove '?' instances:

rm -rf data/signals/\?

## Vectorize (do LPC analysis):

ecoz2 lpc -P 36 -W 45 -O 15 -m 10 -s 0.8 data/signals

## Generate codebooks:

ecoz2 vq learn -P 36 -e 0.0005 data/predictors/TRAIN

## Quantize

ecoz2 vq quantize --codebook data/codebooks/_/eps_0.0005_M_2048.cbook data/predictors/TRAIN

ecoz2 vq quantize --codebook data/codebooks/_/eps_0.0005_M_2048.cbook data/predictors/TEST


## HMM training

for class in `ls data/sequences/TRAIN/M2048/`; do
  ecoz2 hmm learn -a 0.1 -I 30 -N 64 data/sequences/TRAIN/M2048/$class &
done

## HMM classification

ecoz2 hmm classify --models data/hmms/N64__M2048_t3__a0.1_I30 --sequences data/sequences/TRAIN/M2048

ecoz2 hmm classify --models data/hmms/N64__M2048_t3__a0.1_I30 --sequences data/sequences/TEST/M2048

