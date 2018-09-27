# VQ/HMM based classification

## Codebook generation

Using all designated training predictors:

```
vq.learn -P 36 -e 0.0005 data/predictors/TRAIN/*/*.prd
```

Codebooks generated under `data/codebooks/_/`.

## Vector quantization

Quantization using 2048-codeword codebook:

```
vq.quantize data/codebooks/_/eps_0.0005__2048.cbook data/predictors/*/*/*prd
```

## HMM training

Using the designated training sequences:

```
for class in `ls data/sequences/TRAIN/M2048`; do
  hmm.learn -a 0.1 -I 10 -N 64 data/sequences/TRAIN/M2048/$class/*.seq &;
done
```

## HMM classification

### On training sequences:

```
hmm.classify data/hmms/N64__M2048_t3__a0.1_I10/*hmm data/sequences/TRAIN/M2048/*/*seq

Loading models:
 0: data/hmms/N64__M2048_t3__a0.1_I10/ascending_moan.hmm
 1: data/hmms/N64__M2048_t3__a0.1_I10/ascending_shriek.hmm
 2: data/hmms/N64__M2048_t3__a0.1_I10/cry.hmm
 3: data/hmms/N64__M2048_t3__a0.1_I10/descending_moan.hmm
 4: data/hmms/N64__M2048_t3__a0.1_I10/descending_shriek.hmm
 5: data/hmms/N64__M2048_t3__a0.1_I10/groan.hmm
 6: data/hmms/N64__M2048_t3__a0.1_I10/grunt.hmm
 7: data/hmms/N64__M2048_t3__a0.1_I10/grunts.hmm
 8: data/hmms/N64__M2048_t3__a0.1_I10/gurgle.hmm
 9: data/hmms/N64__M2048_t3__a0.1_I10/modulated_cry.hmm
10: data/hmms/N64__M2048_t3__a0.1_I10/modulated_moan.hmm
11: data/hmms/N64__M2048_t3__a0.1_I10/purr.hmm
12: data/hmms/N64__M2048_t3__a0.1_I10/trill.hmm

_********************************_********************************************************************************************************************__**____****_*******************************************************************************************************************************************************************_***************************************************************************************************_***************************************************************************************************************************************************************************************************_******************************************************************_****************************_*********************************

                    Confusion matrix:
                           0   1   2   3   4   5   6   7   8   9  10  11  12     tests   errors

     ascending_moan   0   32   0   1   0   0   0   0   0   0   0   0   0   0       33       1
   ascending_shriek   1    0  74   0   0   0   0   0   0   1   0   0   0   0       75       1
                cry   2    0   0  42   0   0   0   0   0   0   0   0   0   0       42       0
    descending_moan   3    0   0   5 116   0   0   0   0   0   0   2   0   0      123       7
  descending_shriek   4    0   0   0   0  21   0   0   0   0   0   0   0   0       21       0
              groan   5    0   0   0   0   0  32   0   0   0   0   0   0   0       32       0
              grunt   6    0   0   0   0   0   0  80   0   1   0   0   0   0       81       1
             grunts   7    0   0   0   0   0   0   0  19   0   0   0   0   0       19       0
             gurgle   8    0   0   0   0   0   1   0   0 172   0   0   0   0      173       1
      modulated_cry   9    0   0   0   0   0   0   0   0   0  23   0   0   0       23       0
     modulated_moan  10    0   0   0   0   0   1   0   0   0   0  66   0   0       67       1
               purr  11    0   0   1   0   0   0   0   0   0   0   0  28   0       29       1
              trill  12    0   0   0   0   0   0   0   0   0   0   1   0  33       34       1

                    class     accuracy    tests      candidate order
     ascending_moan     0       96.97%    33         32   0   0   0   0   0   1   0   0   0   0   0   0
   ascending_shriek     1       98.67%    75         74   0   0   0   0   0   0   0   0   0   0   1   0
                cry     2      100.00%    42         42   0   0   0   0   0   0   0   0   0   0   0   0
    descending_moan     3       94.31%   123        116   4   2   0   0   1   0   0   0   0   0   0   0
  descending_shriek     4      100.00%    21         21   0   0   0   0   0   0   0   0   0   0   0   0
              groan     5      100.00%    32         32   0   0   0   0   0   0   0   0   0   0   0   0
              grunt     6       98.77%    81         80   0   1   0   0   0   0   0   0   0   0   0   0
             grunts     7      100.00%    19         19   0   0   0   0   0   0   0   0   0   0   0   0
             gurgle     8       99.42%   173        172   1   0   0   0   0   0   0   0   0   0   0   0
      modulated_cry     9      100.00%    23         23   0   0   0   0   0   0   0   0   0   0   0   0
     modulated_moan    10       98.51%    67         66   0   1   0   0   0   0   0   0   0   0   0   0
               purr    11       96.55%    29         28   0   0   0   1   0   0   0   0   0   0   0   0
              trill    12       97.06%    34         33   0   0   1   0   0   0   0   0   0   0   0   0

                      TOTAL     98.14%   752        738   5   4   1   1   1   1   0   0   0   0   1   0
```

### On test sequences:

```
hmm.classify data/hmms/N64__M2048_t3__a0.1_I10/*hmm data/sequences/TEST/M2048/*/*seq

Loading models:
 0: data/hmms/N64__M2048_t3__a0.1_I10/ascending_moan.hmm
 1: data/hmms/N64__M2048_t3__a0.1_I10/ascending_shriek.hmm
 2: data/hmms/N64__M2048_t3__a0.1_I10/cry.hmm
 3: data/hmms/N64__M2048_t3__a0.1_I10/descending_moan.hmm
 4: data/hmms/N64__M2048_t3__a0.1_I10/descending_shriek.hmm
 5: data/hmms/N64__M2048_t3__a0.1_I10/groan.hmm
 6: data/hmms/N64__M2048_t3__a0.1_I10/grunt.hmm
 7: data/hmms/N64__M2048_t3__a0.1_I10/grunts.hmm
 8: data/hmms/N64__M2048_t3__a0.1_I10/gurgle.hmm
 9: data/hmms/N64__M2048_t3__a0.1_I10/modulated_cry.hmm
10: data/hmms/N64__M2048_t3__a0.1_I10/modulated_moan.hmm
11: data/hmms/N64__M2048_t3__a0.1_I10/purr.hmm
12: data/hmms/N64__M2048_t3__a0.1_I10/trill.hmm

____*_____**___*_*********_**_*________**___******_****_***____*****_**____**______*****_************____**_*************_*_****_*_*______********_*___******___**_*____**___***__

                    Confusion matrix:
                           0   1   2   3   4   5   6   7   8   9  10  11  12     tests   errors

     ascending_moan   0    1   0   4   1   0   0   0   1   0   0   0   0   0        7       6
   ascending_shriek   1    1  11   0   1   0   0   0   0   5   0   0   0   0       18       7
                cry   2    0   0   4   2   0   0   0   0   1   0   1   2   0       10       6
    descending_moan   3    1   2   2  17   0   1   0   2   0   0   1   1   3       30      13
  descending_shriek   4    0   1   0   0   4   0   0   0   0   0   0   0   0        5       1
              groan   5    0   0   1   0   0   3   0   0   3   0   0   0   0        7       4
              grunt   6    0   0   0   1   0   2  13   0   3   0   1   0   0       20       7
             grunts   7    0   0   0   0   0   0   0   4   0   0   0   0   0        4       0
             gurgle   8    0   1   3   3   0   2   2   0  27   0   2   1   1       42      15
      modulated_cry   9    0   0   0   0   1   0   0   0   0   4   0   0   0        5       1
     modulated_moan  10    0   0   2   3   0   1   1   0   0   0   9   0   0       16       7
               purr  11    0   0   0   1   0   1   0   0   2   0   0   2   0        6       4
              trill  12    0   0   0   1   0   1   1   0   1   1   0   0   3        8       5

                    class     accuracy    tests      candidate order
     ascending_moan     0       14.29%     7          1   2   0   0   2   1   0   0   0   1   0   0   0
   ascending_shriek     1       61.11%    18         11   0   2   2   0   0   0   2   0   1   0   0   0
                cry     2       40.00%    10          4   2   1   1   1   1   0   0   0   0   0   0   0
    descending_moan     3       56.67%    30         17   6   1   3   3   0   0   0   0   0   0   0   0
  descending_shriek     4       80.00%     5          4   1   0   0   0   0   0   0   0   0   0   0   0
              groan     5       42.86%     7          3   0   2   2   0   0   0   0   0   0   0   0   0
              grunt     6       65.00%    20         13   4   0   2   1   0   0   0   0   0   0   0   0
             grunts     7      100.00%     4          4   0   0   0   0   0   0   0   0   0   0   0   0
             gurgle     8       64.29%    42         27   9   1   0   1   1   1   1   1   0   0   0   0
      modulated_cry     9       80.00%     5          4   1   0   0   0   0   0   0   0   0   0   0   0
     modulated_moan    10       56.25%    16          9   2   2   1   0   1   1   0   0   0   0   0   0
               purr    11       33.33%     6          2   1   1   1   0   1   0   0   0   0   0   0   0
              trill    12       37.50%     8          3   0   1   0   1   0   1   1   0   0   0   1   0

                      TOTAL     57.30%   178        102  28  11  12   9   5   3   4   1   2   0   1   0
```
