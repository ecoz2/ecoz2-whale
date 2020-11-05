A DFT/LPC pair of spectrograms per class, selected arbitrarily:

    sgn.plot.spec.py --lpc 20 \
      --signal ../MARS_20161221_000046_SongSession_16kHz_HPF5Hz.wav \
      --segments ../exerc01/MARS_20161221_000046_SongSession_16kHz_HPF5HzNorm_labels.csv \
      --selection 1 3 22 43 50 55 65 108 179 180 188 268 274 477 481 660 681 909 1011 1208 1477 1951 2424 \
      --no-plot \
      --out-prefix=spectrograms/arbitrary-selection/
