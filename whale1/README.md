# Basic VQ and VQ/HMM based song unit classification

The exercise here was done on selections corresponding 
to a single song file: `HBSe_20151207T070326.wav`

The selection WAV files are located (in a separated space) at:

```
../../ecoz/data/signals/*/*HBSe_20151207T070326_*wav
```

## Predictor files

The conversion of the wave files to linear prediction coding vectors
is done with the `lpc` program, which puts the generated files under
`data/predictors/`:

```
lpc -P 36 -W 45 -O 15 -m 6 -s 0.8 ../../ecoz/data/signals/*/*HBSe_20151207T070326_*wav
```

- `-P 36`: 36-order prediction;
- `-W 45`: 45-ms analysis window size;
- `-O 15`: 15-ms window offset;
- `-m 6`: only consider classes with at least 6 signal files;
- `-s 0.8`: to split the set of files into approximately 80% for a
  training subset and 20% for a testing subset.
  With this option the resulting predictor files get generated under
  `data/predictors/TRAIN/` and `data/predictors/TEST/` respectively.

The 8 classes considered according to given parameters:

```
ls data/predictors/TRAIN

descending_moan   groan             gurgle            modulated_cry
descending_shriek groan_+_purr      gurgle?           purr
```

See:

- `vq.md`: A basic VQ based classification, mainly intended to help
  verify the implementation of the clustering algorithm, but also
  to gain some idea about the accuracy of the quantization in general.
  
- `hmm.md`: VQ/HMM based classification
