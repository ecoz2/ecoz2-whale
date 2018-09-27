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

### M=2048 on training instances

```
➜  whale10 git:(master) ✗ vq.classify -r data/codebooks/[a-z]*/eps_0.0005__2048.cbook data/predictors/TRAIN/*/*.prd

Loading models:
 0: data/codebooks/ascending_moan/eps_0.0005__2048.cbook         : 'ascending_moan'
 1: data/codebooks/ascending_shriek/eps_0.0005__2048.cbook       : 'ascending_shriek'
 2: data/codebooks/cry/eps_0.0005__2048.cbook                    : 'cry'
 3: data/codebooks/descending_moan/eps_0.0005__2048.cbook        : 'descending_moan'
 4: data/codebooks/descending_shriek/eps_0.0005__2048.cbook      : 'descending_shriek'
 5: data/codebooks/groan/eps_0.0005__2048.cbook                  : 'groan'
 6: data/codebooks/grunt/eps_0.0005__2048.cbook                  : 'grunt'
 7: data/codebooks/grunts/eps_0.0005__2048.cbook                 : 'grunts'
 8: data/codebooks/gurgle/eps_0.0005__2048.cbook                 : 'gurgle'
 9: data/codebooks/modulated_cry/eps_0.0005__2048.cbook          : 'modulated_cry'
10: data/codebooks/modulated_moan/eps_0.0005__2048.cbook         : 'modulated_moan'
11: data/codebooks/purr/eps_0.0005__2048.cbook                   : 'purr'
12: data/codebooks/trill/eps_0.0005__2048.cbook                  : 'trill'

*************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************_
data/predictors/TRAIN/gurgle/from_HBSe_20151121T040102__258.45837_259.85187.prd: 'gurgle'
  [ 0]   data/codebooks/modulated_moan/eps_0.0005__2048.cbook         : 3.932300e-02  : 'modulated_moan'
  [ 1] * data/codebooks/gurgle/eps_0.0005__2048.cbook                 : 3.943296e-02  : 'gurgle'

******************************************************************************************************************************************************************************************************************************************************************************************

                    Confusion matrix:
                           0   1   2   3   4   5   6   7   8   9  10  11  12     tests   errors

     ascending_moan   0   33   0   0   0   0   0   0   0   0   0   0   0   0       33       0
   ascending_shriek   1    0  75   0   0   0   0   0   0   0   0   0   0   0       75       0
                cry   2    0   0  42   0   0   0   0   0   0   0   0   0   0       42       0
    descending_moan   3    0   0   0 123   0   0   0   0   0   0   0   0   0      123       0
  descending_shriek   4    0   0   0   0  21   0   0   0   0   0   0   0   0       21       0
              groan   5    0   0   0   0   0  32   0   0   0   0   0   0   0       32       0
              grunt   6    0   0   0   0   0   0  81   0   0   0   0   0   0       81       0
             grunts   7    0   0   0   0   0   0   0  19   0   0   0   0   0       19       0
             gurgle   8    0   0   0   0   0   0   0   0 172   0   1   0   0      173       1
      modulated_cry   9    0   0   0   0   0   0   0   0   0  23   0   0   0       23       0
     modulated_moan  10    0   0   0   0   0   0   0   0   0   0  67   0   0       67       0
               purr  11    0   0   0   0   0   0   0   0   0   0   0  29   0       29       0
              trill  12    0   0   0   0   0   0   0   0   0   0   0   0  34       34       0

                    class     accuracy    tests      candidate order
     ascending_moan     0      100.00%    33         33   0   0   0   0   0   0   0   0   0   0   0   0
   ascending_shriek     1      100.00%    75         75   0   0   0   0   0   0   0   0   0   0   0   0
                cry     2      100.00%    42         42   0   0   0   0   0   0   0   0   0   0   0   0
    descending_moan     3      100.00%   123        123   0   0   0   0   0   0   0   0   0   0   0   0
  descending_shriek     4      100.00%    21         21   0   0   0   0   0   0   0   0   0   0   0   0
              groan     5      100.00%    32         32   0   0   0   0   0   0   0   0   0   0   0   0
              grunt     6      100.00%    81         81   0   0   0   0   0   0   0   0   0   0   0   0
             grunts     7      100.00%    19         19   0   0   0   0   0   0   0   0   0   0   0   0
             gurgle     8       99.42%   173        172   1   0   0   0   0   0   0   0   0   0   0   0
      modulated_cry     9      100.00%    23         23   0   0   0   0   0   0   0   0   0   0   0   0
     modulated_moan    10      100.00%    67         67   0   0   0   0   0   0   0   0   0   0   0   0
               purr    11      100.00%    29         29   0   0   0   0   0   0   0   0   0   0   0   0
              trill    12      100.00%    34         34   0   0   0   0   0   0   0   0   0   0   0   0

                      TOTAL     99.87%   752        751   1   0   0   0   0   0   0   0   0   0   0   0
```

### M=2048 on test instances

```
vq.classify data/codebooks/[a-z]*/eps_0.0005__2048.cbook data/predictors/TEST/*/*.prd

Loading models:
 0: data/codebooks/ascending_moan/eps_0.0005__2048.cbook         : 'ascending_moan'
 1: data/codebooks/ascending_shriek/eps_0.0005__2048.cbook       : 'ascending_shriek'
 2: data/codebooks/cry/eps_0.0005__2048.cbook                    : 'cry'
 3: data/codebooks/descending_moan/eps_0.0005__2048.cbook        : 'descending_moan'
 4: data/codebooks/descending_shriek/eps_0.0005__2048.cbook      : 'descending_shriek'
 5: data/codebooks/groan/eps_0.0005__2048.cbook                  : 'groan'
 6: data/codebooks/grunt/eps_0.0005__2048.cbook                  : 'grunt'
 7: data/codebooks/grunts/eps_0.0005__2048.cbook                 : 'grunts'
 8: data/codebooks/gurgle/eps_0.0005__2048.cbook                 : 'gurgle'
 9: data/codebooks/modulated_cry/eps_0.0005__2048.cbook          : 'modulated_cry'
10: data/codebooks/modulated_moan/eps_0.0005__2048.cbook         : 'modulated_moan'
11: data/codebooks/purr/eps_0.0005__2048.cbook                   : 'purr'
12: data/codebooks/trill/eps_0.0005__2048.cbook                  : 'trill'

____*_____*____*_************_*________**___***************_*__*****_**____*_*_____*****__**_********____**__*******___**_*****___________*_**_*****__*******___**_*_*__**___**___

                    Confusion matrix:
                           0   1   2   3   4   5   6   7   8   9  10  11  12     tests   errors

     ascending_moan   0    1   0   4   1   0   0   1   0   0   0   0   0   0        7       6
   ascending_shriek   1    1  10   1   2   0   0   0   0   3   0   0   0   1       18       8
                cry   2    0   0   5   3   0   0   1   0   0   0   0   1   0       10       5
    descending_moan   3    0   2   2  20   0   1   0   1   0   0   1   0   3       30      10
  descending_shriek   4    0   1   0   0   4   0   0   0   0   0   0   0   0        5       1
              groan   5    0   0   1   0   0   2   0   0   0   0   4   0   0        7       5
              grunt   6    0   0   0   1   0   1  12   0   3   0   3   0   0       20       8
             grunts   7    0   0   0   0   0   0   0   4   0   0   0   0   0        4       0
             gurgle   8    1   0   3   7   0   3   0   0  19   1   6   0   2       42      23
      modulated_cry   9    0   0   0   0   0   0   0   0   0   5   0   0   0        5       0
     modulated_moan  10    0   0   1   4   0   1   0   0   0   0  10   0   0       16       6
               purr  11    0   0   0   1   0   1   0   0   1   0   0   3   0        6       3
              trill  12    0   0   0   2   0   1   0   0   1   1   0   1   2        8       6

                    class     accuracy    tests      candidate order
     ascending_moan     0       14.29%     7          1   3   0   0   2   0   0   0   0   1   0   0   0
   ascending_shriek     1       55.56%    18         10   2   0   2   1   1   1   1   0   0   0   0   0
                cry     2       50.00%    10          5   2   0   2   1   0   0   0   0   0   0   0   0
    descending_moan     3       66.67%    30         20   5   4   0   0   0   0   0   1   0   0   0   0
  descending_shriek     4       80.00%     5          4   1   0   0   0   0   0   0   0   0   0   0   0
              groan     5       28.57%     7          2   1   0   3   0   1   0   0   0   0   0   0   0
              grunt     6       60.00%    20         12   4   1   1   1   1   0   0   0   0   0   0   0
             grunts     7      100.00%     4          4   0   0   0   0   0   0   0   0   0   0   0   0
             gurgle     8       45.24%    42         19   6   9   3   2   1   2   0   0   0   0   0   0
      modulated_cry     9      100.00%     5          5   0   0   0   0   0   0   0   0   0   0   0   0
     modulated_moan    10       62.50%    16         10   3   1   0   0   2   0   0   0   0   0   0   0
               purr    11       50.00%     6          3   0   2   0   0   1   0   0   0   0   0   0   0
              trill    12       25.00%     8          2   2   0   1   1   0   0   2   0   0   0   0   0

                      TOTAL     54.49%   178         97  29  17  12   8   7   3   3   1   1   0   0   0
```

### M=1024 on training instances

```
vq.classify data/codebooks/[a-z]*/eps_0.0005__1024.cbook data/predictors/TRAIN/*/*.prd

Loading models:
 0: data/codebooks/ascending_moan/eps_0.0005__1024.cbook         : 'ascending_moan'
 1: data/codebooks/ascending_shriek/eps_0.0005__1024.cbook       : 'ascending_shriek'
 2: data/codebooks/cry/eps_0.0005__1024.cbook                    : 'cry'
 3: data/codebooks/descending_moan/eps_0.0005__1024.cbook        : 'descending_moan'
 4: data/codebooks/descending_shriek/eps_0.0005__1024.cbook      : 'descending_shriek'
 5: data/codebooks/groan/eps_0.0005__1024.cbook                  : 'groan'
 6: data/codebooks/grunt/eps_0.0005__1024.cbook                  : 'grunt'
 7: data/codebooks/grunts/eps_0.0005__1024.cbook                 : 'grunts'
 8: data/codebooks/gurgle/eps_0.0005__1024.cbook                 : 'gurgle'
 9: data/codebooks/modulated_cry/eps_0.0005__1024.cbook          : 'modulated_cry'
10: data/codebooks/modulated_moan/eps_0.0005__1024.cbook         : 'modulated_moan'
11: data/codebooks/purr/eps_0.0005__1024.cbook                   : 'purr'
12: data/codebooks/trill/eps_0.0005__1024.cbook                  : 'trill'

************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************_******************************_**_**_********************************************************************************************_*******_***_***********************_*********************************************************************************************************************************************************

                    Confusion matrix:
                           0   1   2   3   4   5   6   7   8   9  10  11  12     tests   errors

     ascending_moan   0   33   0   0   0   0   0   0   0   0   0   0   0   0       33       0
   ascending_shriek   1    0  75   0   0   0   0   0   0   0   0   0   0   0       75       0
                cry   2    0   0  42   0   0   0   0   0   0   0   0   0   0       42       0
    descending_moan   3    0   0   0 123   0   0   0   0   0   0   0   0   0      123       0
  descending_shriek   4    0   0   0   0  21   0   0   0   0   0   0   0   0       21       0
              groan   5    0   0   0   0   0  32   0   0   0   0   0   0   0       32       0
              grunt   6    0   0   0   0   0   0  81   0   0   0   0   0   0       81       0
             grunts   7    0   0   0   0   0   0   0  19   0   0   0   0   0       19       0
             gurgle   8    0   0   1   2   0   0   0   0 165   1   4   0   0      173       8
      modulated_cry   9    0   0   0   0   0   0   0   0   0  23   0   0   0       23       0
     modulated_moan  10    0   0   0   0   0   0   0   0   0   0  67   0   0       67       0
               purr  11    0   0   0   0   0   0   0   0   0   0   0  29   0       29       0
              trill  12    0   0   0   0   0   0   0   0   0   0   0   0  34       34       0

                    class     accuracy    tests      candidate order
     ascending_moan     0      100.00%    33         33   0   0   0   0   0   0   0   0   0   0   0   0
   ascending_shriek     1      100.00%    75         75   0   0   0   0   0   0   0   0   0   0   0   0
                cry     2      100.00%    42         42   0   0   0   0   0   0   0   0   0   0   0   0
    descending_moan     3      100.00%   123        123   0   0   0   0   0   0   0   0   0   0   0   0
  descending_shriek     4      100.00%    21         21   0   0   0   0   0   0   0   0   0   0   0   0
              groan     5      100.00%    32         32   0   0   0   0   0   0   0   0   0   0   0   0
              grunt     6      100.00%    81         81   0   0   0   0   0   0   0   0   0   0   0   0
             grunts     7      100.00%    19         19   0   0   0   0   0   0   0   0   0   0   0   0
             gurgle     8       95.38%   173        165   5   3   0   0   0   0   0   0   0   0   0   0
      modulated_cry     9      100.00%    23         23   0   0   0   0   0   0   0   0   0   0   0   0
     modulated_moan    10      100.00%    67         67   0   0   0   0   0   0   0   0   0   0   0   0
               purr    11      100.00%    29         29   0   0   0   0   0   0   0   0   0   0   0   0
              trill    12      100.00%    34         34   0   0   0   0   0   0   0   0   0   0   0   0

                      TOTAL     98.94%   752        744   5   3   0   0   0   0   0   0   0   0   0   0
```

### M=1024 on test instances:

```
vq.classify data/codebooks/[a-z]*/eps_0.0005__1024.cbook data/predictors/TEST/*/*.prd

Loading models:
 0: data/codebooks/ascending_moan/eps_0.0005__1024.cbook         : 'ascending_moan'
 1: data/codebooks/ascending_shriek/eps_0.0005__1024.cbook       : 'ascending_shriek'
 2: data/codebooks/cry/eps_0.0005__1024.cbook                    : 'cry'
 3: data/codebooks/descending_moan/eps_0.0005__1024.cbook        : 'descending_moan'
 4: data/codebooks/descending_shriek/eps_0.0005__1024.cbook      : 'descending_shriek'
 5: data/codebooks/groan/eps_0.0005__1024.cbook                  : 'groan'
 6: data/codebooks/grunt/eps_0.0005__1024.cbook                  : 'grunt'
 7: data/codebooks/grunts/eps_0.0005__1024.cbook                 : 'grunts'
 8: data/codebooks/gurgle/eps_0.0005__1024.cbook                 : 'gurgle'
 9: data/codebooks/modulated_cry/eps_0.0005__1024.cbook          : 'modulated_cry'
10: data/codebooks/modulated_moan/eps_0.0005__1024.cbook         : 'modulated_moan'
11: data/codebooks/purr/eps_0.0005__1024.cbook                   : 'purr'
12: data/codebooks/trill/eps_0.0005__1024.cbook                  : 'trill'

*_*_*_____*____*_**************________**___***************_*___****_**____*_*_____*****__***********____**__*******___*__****____________*_**_**_**___******___**_*_*_***__****__

                    Confusion matrix:
                           0   1   2   3   4   5   6   7   8   9  10  11  12     tests   errors

     ascending_moan   0    3   0   2   1   0   0   1   0   0   0   0   0   0        7       4
   ascending_shriek   1    2  10   1   1   0   0   0   0   3   0   0   0   1       18       8
                cry   2    0   0   6   3   0   0   0   0   0   0   0   1   0       10       4
    descending_moan   3    0   2   3  19   0   1   0   1   0   0   1   0   3       30      11
  descending_shriek   4    0   1   0   0   4   0   0   0   0   0   0   0   0        5       1
              groan   5    0   0   2   0   0   2   0   0   0   0   3   0   0        7       5
              grunt   6    0   0   0   1   0   0  13   0   3   0   2   1   0       20       7
             grunts   7    0   0   0   0   0   0   0   4   0   0   0   0   0        4       0
             gurgle   8    1   0   4   8   1   4   0   1  17   1   4   0   1       42      25
      modulated_cry   9    0   0   0   0   1   0   0   0   0   4   0   0   0        5       1
     modulated_moan  10    0   0   3   3   0   1   0   0   0   0   9   0   0       16       7
               purr  11    0   0   0   0   0   1   0   0   1   0   0   4   0        6       2
              trill  12    0   0   0   1   0   0   0   0   1   1   0   1   4        8       4

                    class     accuracy    tests      candidate order
     ascending_moan     0       42.86%     7          3   1   1   0   1   0   0   0   0   1   0   0   0
   ascending_shriek     1       55.56%    18         10   2   1   1   1   1   1   1   0   0   0   0   0
                cry     2       60.00%    10          6   1   1   1   0   1   0   0   0   0   0   0   0
    descending_moan     3       63.33%    30         19   6   2   2   0   0   0   0   1   0   0   0   0
  descending_shriek     4       80.00%     5          4   1   0   0   0   0   0   0   0   0   0   0   0
              groan     5       28.57%     7          2   1   0   3   0   1   0   0   0   0   0   0   0
              grunt     6       65.00%    20         13   3   2   0   1   1   0   0   0   0   0   0   0
             grunts     7      100.00%     4          4   0   0   0   0   0   0   0   0   0   0   0   0
             gurgle     8       40.48%    42         17   5  13   1   3   1   1   1   0   0   0   0   0
      modulated_cry     9       80.00%     5          4   1   0   0   0   0   0   0   0   0   0   0   0
     modulated_moan    10       56.25%    16          9   4   1   0   0   2   0   0   0   0   0   0   0
               purr    11       66.67%     6          4   0   1   0   1   0   0   0   0   0   0   0   0
              trill    12       50.00%     8          4   0   1   0   1   0   0   1   1   0   0   0   0

                      TOTAL     55.62%   178         99  25  23   8   8   7   2   3   2   1   0   0   0
```

### Summary

Correct classifications:

```
codebook size \  on training  | on test
         2048    99.87%       |  54.49%
         1024    98.94%       |  55.62%
          512    95.61%       |  55.06%
          256    92.15%       |  54.49%
          128    86.17%       |  52.25%
           64    78.06%       |  51.69%
           32    67.69%       |  47.75%
           16    63.16%       |  46.07%
            8    53.59%       |  37.64%
```
