## Sequence length histograms

Based on the TEST sequences.

```
python3 seq-hists/seq-len-extract.py c12n/TEST/N3__M2048_t3__a0.3_I1.csv seq-hists/seq-lengths.csv

python3 seq-hists/seq-histogram.py seq-hists/seq-lengths.csv
```

In each of the plots below:

- `n` is the number of sequences
- `µ` is the average sequence length
- `b` is the number of bins
- `Length` is given in number of analysis frames.
  With the 15ms window offset, this means that
  100 units in the x axis corresponds to about 1.5secs

All plots on the same `x` axis range to facilitate comparison.

First plot with sequences across all classes:

![](ALL-histogram.png)

Per class:

![](A-histogram.png)
![](Bm-histogram.png)
![](C-histogram.png)
![](E-histogram.png)
![](F-histogram.png)
![](G2-histogram.png)
![](I3-histogram.png)
![](II-histogram.png)
