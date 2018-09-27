# VQ/HMM based classification

## Codebook generation

Using all designated training predictors:

```
vq.learn -P 36 -e 0.0005 data/predictors/TRAIN/*/*.prd
```

Codebooks generated under `data/codebooks/_/`.

## Vector quantization

Quantization using 512-codeword codebook:

```
vq.quantize data/codebooks/_/eps_0.0005__0512.cbook data/predictors/*/*/*prd
```

## HMM training

Using the designated training sequences:

```
for class in `ls data/sequences/TRAIN/M512`; do
  hmm.learn -N 16 data/sequences/TRAIN/M512/$class/*.seq &;
done
```

HMM models generated under `data/hmms/N16__M512_t3__a0.3/`.

## HMM classification

### On training sequences:

```
hmm.classify data/hmms/N16__M512_t3__a0.3/*hmm  data/sequences/TRAIN/M512/*/*seq

Loading models:
 0: data/hmms/N16__M512_t3__a0.3/descending_moan.hmm
 1: data/hmms/N16__M512_t3__a0.3/descending_shriek.hmm
 2: data/hmms/N16__M512_t3__a0.3/groan.hmm
 3: data/hmms/N16__M512_t3__a0.3/groan_+_purr.hmm
 4: data/hmms/N16__M512_t3__a0.3/gurgle.hmm
 5: data/hmms/N16__M512_t3__a0.3/gurgle?.hmm
 6: data/hmms/N16__M512_t3__a0.3/modulated_cry.hmm
 7: data/hmms/N16__M512_t3__a0.3/purr.hmm

********_****_********_*****_*************************_**************

                    Confusion matrix:
                           0   1   2   3   4   5   6   7     tests   errors

    descending_moan   0    8   0   0   0   0   0   0   0        8       0
  descending_shriek   1    0   4   0   0   1   0   0   0        5       1
              groan   2    0   0   8   0   1   0   0   0        9       1
       groan_+_purr   3    0   0   1   5   0   0   0   0        6       1
             gurgle   4    0   0   0   0  20   1   0   0       21       1
            gurgle?   5    0   0   0   0   0   5   0   0        5       0
      modulated_cry   6    0   0   0   0   0   1   9   0       10       1
               purr   7    0   0   0   0   0   0   0   5        5       0

                    class     accuracy    tests      candidate order
    descending_moan     0      100.00%     8          8   0   0   0   0   0   0   0
  descending_shriek     1       80.00%     5          4   1   0   0   0   0   0   0
              groan     2       88.89%     9          8   1   0   0   0   0   0   0
       groan_+_purr     3       83.33%     6          5   1   0   0   0   0   0   0
             gurgle     4       95.24%    21         20   1   0   0   0   0   0   0
            gurgle?     5      100.00%     5          5   0   0   0   0   0   0   0
      modulated_cry     6       90.00%    10          9   1   0   0   0   0   0   0
               purr     7      100.00%     5          5   0   0   0   0   0   0   0

                      TOTAL     92.75%    69         64   5   0   0   0   0   0   0
```

### On test sequences:

```
hmm.classify data/hmms/N16__M512_t3__a0.3/*hmm  data/sequences/TEST/M512/*/*seq

Loading models:
 0: data/hmms/N16__M512_t3__a0.3/descending_moan.hmm
 1: data/hmms/N16__M512_t3__a0.3/descending_shriek.hmm
 2: data/hmms/N16__M512_t3__a0.3/groan.hmm
 3: data/hmms/N16__M512_t3__a0.3/groan_+_purr.hmm
 4: data/hmms/N16__M512_t3__a0.3/gurgle.hmm
 5: data/hmms/N16__M512_t3__a0.3/gurgle?.hmm
 6: data/hmms/N16__M512_t3__a0.3/modulated_cry.hmm
 7: data/hmms/N16__M512_t3__a0.3/purr.hmm

_**_********

                    Confusion matrix:
                           0   1   2   3   4   5   6   7     tests   errors

    descending_moan   0    0   0   1   0   0   0   0   0        1       1
  descending_shriek   1    0   1   0   0   0   0   0   0        1       0
              groan   2    0   0   1   0   0   0   0   0        1       0
       groan_+_purr   3    0   0   1   0   0   0   0   0        1       1
             gurgle   4    0   0   0   0   4   0   0   0        4       0
            gurgle?   5    0   0   0   0   0   1   0   0        1       0
      modulated_cry   6    0   0   0   0   0   0   2   0        2       0
               purr   7    0   0   0   0   0   0   0   1        1       0

                    class     accuracy    tests      candidate order
    descending_moan     0        0.00%     1          0   0   1   0   0   0   0   0
  descending_shriek     1      100.00%     1          1   0   0   0   0   0   0   0
              groan     2      100.00%     1          1   0   0   0   0   0   0   0
       groan_+_purr     3        0.00%     1          0   1   0   0   0   0   0   0
             gurgle     4      100.00%     4          4   0   0   0   0   0   0   0
            gurgle?     5      100.00%     1          1   0   0   0   0   0   0   0
      modulated_cry     6      100.00%     2          2   0   0   0   0   0   0   0
               purr     7      100.00%     1          1   0   0   0   0   0   0   0

                      TOTAL     83.33%    12         10   1   1   0   0   0   0   0
```
