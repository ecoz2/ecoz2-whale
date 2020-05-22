# On a 4.5 hour recording

Similar to ../exerc03a but considering only the windy interval.

- WAV file: `MARS_20161221_000046_SongSession_16kHz_HPF5Hz.wav`

- Selection file: `../exerc01/MARS_20161221_000046_SongSession_16kHz_HPF5HzNorm_labels.csv`.


## Extracting the individual unit instances

```
$ ecoz2 sgn extract --segments ../exerc01/MARS_20161221_000046_SongSession_16kHz_HPF5HzNorm_labels.csv \
                    --wav ${SOURCE_WAV} \
                    --time-ranges 6000-10500 \
                    --out-dir data/signals

Loading .../MARS_20161221_000046_SongSession_16kHz_HPF5Hz.wav
num_samples: 266117287  sample_rate: 16000  bits_per_sample: 16  sample_format = Int
duration: 16632  sample_period: 0.0000625
parsed selection_ranges = []
parsed time_ranges = [(6000.0, 10500.0)]
      I4   17 instances
       E  302 instances
       I  205 instances
      E1   16 instances
       F  130 instances
      G2   98 instances
       A  190 instances
      Bu   43 instances
      I3  120 instances
      C1    6 instances
      I2  221 instances
       C  207 instances
      EG    3 instances
       ?    2 instances
       H   49 instances
       G   37 instances
       P   72 instances
       B    8 instances
       D   72 instances
      Bm  166 instances
      Bd   30 instances
       M   29 instances
          2023 total extracted instances
```

```
$ rm -rf data/signals/\?
```

## Generating the LPC prediction vector sequences

```
ecoz2 lpc -P 36 -W 45 -O 15 -m 10 data/signals
```

## Generating the TRAIN and TEST predictor lists

`tt-list.csv` will contain all the available predictor filenames with
~80% per class marked as "TRAIN" and ~20% as "TEST":

```
echo "tt,class,selection" > tt-list.csv
for class in `ls data/predictors/`; do
    ecoz2 util split --train-fraction 0.8 --file-ext .prd --files data/predictors/${class} >> tt-list.csv
done
```

The totals:
```
$ grep TRAIN tt-list.csv| wc -l
    1596
$ grep TEST tt-list.csv| wc -l
    408
```

## Codebook generation

Using all TRAIN instances:

```
$ ecoz2 vq learn --prediction-order 36 --epsilon 0.0005 --predictors tt-list.csv

vq_learn: base_codebook_opt=None prediction_order=Some(36), epsilon=0.0005 codebook_class_name=_ predictor_filenames: 1596

Codebook generation:

prediction_order=36 class='_'  epsilon=0.0005

161199 training vectors (ε=0.0005)
Report: data/codebooks/_/eps_0.0005.rpt
...
```

The resulting clustering metrics above are shown in the following plot:

```
cb.plot_evaluation.py data/codebooks/_/eps_0.0005.rpt.csv
```

![](cb_evaluation.png)

## Vector quantization

Quantize all vectors (TRAIN and TEST) using a number of the various
codebook sizes:

```
for M in 0032 0064 0128 0256 0512 1024 2048 4096; do 
   ecoz2 vq quantize --codebook data/codebooks/_/eps_0.0005_M_${M}.cbook data/predictors
done
```

Resulting sequences get generated under `data/sequences/M<M>/`.

## HMM training and classification

Running ./hmm-exercise.sh

![](summary.png)

![](summary1.png)

![](summary2.png)
