2020-10

- add [exerc06](exerc06)
  - as exerc05c but merging "I" and "I2" (into a "II" class)
  - HMM part updated with a rerun using `double` for probabilities (ecoz2 v0.5.1)
  - add [sequence length histograms](exerc06/seq-hists/)
  - add sequence classification rank vs. length scatter plot
  - adjust exerc06/summary-parallel.py to use log scale for `M`
  - add some more HMM runs

2020-08

- add [exerc05b](exerc05b), as exerc05 but only considering classes with at least 100 instances.
  Besides HMM and Naive Bayes, this also has the VQ based classification.
- add [exerc05](exerc05), as exerc1 but with the P = 20.

2020-06

- exerc02: run `c12n.plot.py` for classes A and F (test cases)
- exerc02: For possible reference, [exerc02/c12n/TRAIN/](exerc02/c12n/TRAIN/)
  with some similar plots but for training instances.

2020-05

- rerun exerc02, resulting in an increase in average accuracy to 75% from 70%.
- add [exerc02](exerc02), basically a rerun of exerc1 with the same base
  signal but with different train and test sets and also using new
  file organization is ecoz2 (based on a tt-list.csv)

- remove data from version control to simplify things a bit

- general update of the exerc01 exercise,
  see [exerc01/README.md](exerc01/README.md).

2020-03

- run VQ based classification.
  see [exerc01/vq.md](exerc01/vq.md).
- HMM training parameter variations [exerc01/README.md](exerc01/README.md).

2020-03-14

- add exercise on MARS_20161221_000046_SongSession_16kHz_HPF5HzNorm_labels.
  Note: Direct run of the processing commands with similar parameters as
  in initial exercises, in particular, no model tuning at all.

2019-07-07

- Include the annotated selection data to make this repo more self-contained
  (except for the ECOZ2 executables).
- Point to the Oct 1, 2018 presentation.

2018-09-26

- Initial commit with complete exercises
