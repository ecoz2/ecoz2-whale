# On a 4.5 hour recording

Similar to ../exerc02.

- WAV file: `MARS_20161221_000046_SongSession_16kHz_HPF5Hz.wav`

- Selection file: `../exerc01/MARS_20161221_000046_SongSession_16kHz_HPF5HzNorm_labels.csv`.


## Extracting the individual unit instances

```
$ ecoz2 sgn extract --segments ../exerc01/MARS_20161221_000046_SongSession_16kHz_HPF5HzNorm_labels.csv \
                    --wav ${SOURCE_WAV} \
                    --time-ranges 0-6000 10500-9999999 \
                    --out-dir data/signals

Loading .../MARS_20161221_000046_SongSession_16kHz_HPF5Hz.wav
num_samples: 266117287  sample_rate: 16000  bits_per_sample: 16  sample_format = Int
duration: 16632  sample_period: 0.0000625
parsed selection_ranges = []
parsed time_ranges = [(0.0, 6000.0), (10500.0, 9999999.0)]
       F  211 instances
       E  461 instances
       C  345 instances
      E1   16 instances
       M   41 instances
       G   52 instances
       P  126 instances
      I4   25 instances
       I  335 instances
      I2  432 instances
       ?   55 instances
       H   79 instances
      EG    3 instances
       D  118 instances
      C1    8 instances
      G2  181 instances
       B   10 instances
      Bd   49 instances
       A  318 instances
      Bm  335 instances
      I3  208 instances
      Bu   43 instances
          3451 total extracted instances
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
    2700
$ grep TEST tt-list.csv| wc -l
    685
```

## Codebook generation

Using all TRAIN instances:

```
$ ecoz2 vq learn --prediction-order 36 --epsilon 0.0005 --predictors tt-list.csv

vq_learn: base_codebook_opt=None prediction_order=Some(36), epsilon=0.0005 codebook_class_name=_ predictor_filenames: 2700

Codebook generation:

prediction_order=36 class='_'  epsilon=0.0005

257233 training vectors (ε=0.0005)
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
for M in 0256 0512 1024 2048 4096; do 
   ecoz2 vq quantize --codebook data/codebooks/_/eps_0.0005_M_${M}.cbook data/predictors
done
```

Resulting sequences get generated under `data/sequences/M<M>/`.

## HMM training and classification

Running ./hmm-exercise.sh

![](summary.png)

![](summary1.png)

![](summary2.png)
