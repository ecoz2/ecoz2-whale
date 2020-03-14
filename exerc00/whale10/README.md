# Basic VQ and VQ/HMM based song unit classification

The exercise here is done on the selections extracted from all the initial
10 song files, that is, these 1121 files:

```
../data/signals/*/*wav
```

## Predictor files

The conversion of the wave files to linear prediction coding vectors
is done with the `lpc` program, which puts the generated files under
`data/predictors/`:

```
lpc -P 36 -W 45 -O 15 -m 20 -s 0.8 ../data/signals/*/*.wav
```

- `-P 36`: prediction order;
- `-W 45`: 45-ms analysis window size;
- `-O 15`: 15-ms window offset;
- `-m 20`: only consider classes with at least 20 signal files;
- `-s 0.8`: to split the set of files into approximately 80% for a
  training subset and 20% for a testing subset.
  With this option the resulting predictor files get generated under
  `data/predictors/TRAIN/` and `data/predictors/TEST/` respectively.

The 13 classes considered according to given parameters:

```
ls data/predictors/TRAIN

ascending_moan    descending_shriek gurgle            trill
ascending_shriek  groan             modulated_cry
cry               grunt             modulated_moan
descending_moan   grunts            purr
```

The concrete exercises on top of these predictor data are:

- `vq.md`: A basic VQ based classification, mainly intended to help
  verify the implementation of the clustering algorithm, but also
  to gain some idea about the accuracy of the quantization in general.
  
- `hmm.md`: VQ/HMM based classification
