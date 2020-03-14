# VQ based classification

## Codebook generation

Codebooks generated per class and only using the corresponding training
predictors:

```
for class in `ls data/predictors/TRAIN`; do
  vq.learn -P 36 -w "$class" -e 0.0005 data/predictors/TRAIN/$class/*.prd &;
done
```

## VQ classification

### M=512 on training instances

```
$ vq.classify data/codebooks/[a-z]*/eps_0.0005__0512.cbook data/predictors/TRAIN/*/*.prd

Loading models:
 0: data/codebooks/descending_moan/eps_0.0005__0512.cbook        : 'descending_moan'
 1: data/codebooks/descending_shriek/eps_0.0005__0512.cbook      : 'descending_shriek'
 2: data/codebooks/groan/eps_0.0005__0512.cbook                  : 'groan'
 3: data/codebooks/groan_+_purr/eps_0.0005__0512.cbook           : 'groan_+_purr'
 4: data/codebooks/gurgle/eps_0.0005__0512.cbook                 : 'gurgle'
 5: data/codebooks/gurgle?/eps_0.0005__0512.cbook                : 'gurgle?'
 6: data/codebooks/modulated_cry/eps_0.0005__0512.cbook          : 'modulated_cry'
 7: data/codebooks/purr/eps_0.0005__0512.cbook                   : 'purr'

*********************************************************************

                    Confusion matrix:
                           0   1   2   3   4   5   6   7     tests   errors

    descending_moan   0    8   0   0   0   0   0   0   0        8       0
  descending_shriek   1    0   5   0   0   0   0   0   0        5       0
              groan   2    0   0   9   0   0   0   0   0        9       0
       groan_+_purr   3    0   0   0   6   0   0   0   0        6       0
             gurgle   4    0   0   0   0  21   0   0   0       21       0
            gurgle?   5    0   0   0   0   0   5   0   0        5       0
      modulated_cry   6    0   0   0   0   0   0  10   0       10       0
               purr   7    0   0   0   0   0   0   0   5        5       0

                    class     accuracy    tests      candidate order
    descending_moan     0      100.00%     8          8   0   0   0   0   0   0   0
  descending_shriek     1      100.00%     5          5   0   0   0   0   0   0   0
              groan     2      100.00%     9          9   0   0   0   0   0   0   0
       groan_+_purr     3      100.00%     6          6   0   0   0   0   0   0   0
             gurgle     4      100.00%    21         21   0   0   0   0   0   0   0
            gurgle?     5      100.00%     5          5   0   0   0   0   0   0   0
      modulated_cry     6      100.00%    10         10   0   0   0   0   0   0   0
               purr     7      100.00%     5          5   0   0   0   0   0   0   0

                      TOTAL    100.00%    69         69   0   0   0   0   0   0   0
```

### M=512 on test instances:

```
$ vq.classify data/codebooks/[a-z]*/eps_0.0005__0512.cbook data/predictors/TEST/*/*.prd

Loading models:
 0: data/codebooks/descending_moan/eps_0.0005__0512.cbook        : 'descending_moan'
 1: data/codebooks/descending_shriek/eps_0.0005__0512.cbook      : 'descending_shriek'
 2: data/codebooks/groan/eps_0.0005__0512.cbook                  : 'groan'
 3: data/codebooks/groan_+_purr/eps_0.0005__0512.cbook           : 'groan_+_purr'
 4: data/codebooks/gurgle/eps_0.0005__0512.cbook                 : 'gurgle'
 5: data/codebooks/gurgle?/eps_0.0005__0512.cbook                : 'gurgle?'
 6: data/codebooks/modulated_cry/eps_0.0005__0512.cbook          : 'modulated_cry'
 7: data/codebooks/purr/eps_0.0005__0512.cbook                   : 'purr'

_**_********

                    Confusion matrix:
                           0   1   2   3   4   5   6   7     tests   errors

    descending_moan   0    0   0   0   0   0   0   0   1        1       1
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

### Summary

Correct classifications:

```
codebook size \  on training  | on test
         2048   100.00%       |  91.67%
         1024   100.00%       |  83.33%
          512   100.00%       |  83.33%
          256   100.00%       |  83.33%
          128   100.00%       |  83.33%
           64   100.00%       |  83.33%
           32    98.55%       |  75.00%
           16    97.10%       |  66.67%
            8    95.65%       |  66.67%
            4    92.75%       |  50.00%
            2    82.61%       |  66.67%
```
