<blockquote>
local prep:

    PATH=/usr/local/Cellar/python@3.8/3.8.6_1/bin:$PATH
    PATH=../../ecoz2/ecoz2/src/py:$PATH

</blockquote>

### A DFT/LPC pair of spectrograms per class, selected arbitrarily:

    sgn.plot.spec.py \
      --signal ../MARS_20161221_000046_SongSession_16kHz_HPF5Hz.wav \
      --segments ../exerc01/MARS_20161221_000046_SongSession_16kHz_HPF5HzNorm_labels.csv \
      --selection 1 3 22 43 50 55 65 108 179 180 188 268 274 477 481 660 681 909 1011 1208 1477 1951 2424 \
      --window-size 1024 \
      --window-offset 32 \
      --lpc 120 \
      --lpc-window-size 1024 \
      --lpc-window-offset 32 \
      --lpc-num-points-per-window 512 \
      --no-plot \
      --out-prefix=spectrograms/arbitrary-selection/

<blockquote>
 Just to update this readme:

    for x in `ls spectrograms/arbitrary-selection`; do
      echo -e "\n---\n\n### $x\n"
      echo -e "\![](spectrograms/arbitrary-selection/$x)"
    done >> README.md

</blockquote>

---

### sgn.plot.spec_A_3.png

![](spectrograms/arbitrary-selection/sgn.plot.spec_A_3.png)

---

### sgn.plot.spec_B_274.png

![](spectrograms/arbitrary-selection/sgn.plot.spec_B_274.png)

---

### sgn.plot.spec_Bd_2424.png

![](spectrograms/arbitrary-selection/sgn.plot.spec_Bd_2424.png)

---

### sgn.plot.spec_Bm_477.png

![](spectrograms/arbitrary-selection/sgn.plot.spec_Bm_477.png)

---

### sgn.plot.spec_Bu_22.png

![](spectrograms/arbitrary-selection/sgn.plot.spec_Bu_22.png)

---

### sgn.plot.spec_Bu_481.png

![](spectrograms/arbitrary-selection/sgn.plot.spec_Bu_481.png)

---

### sgn.plot.spec_C1_909.png

![](spectrograms/arbitrary-selection/sgn.plot.spec_C1_909.png)

---

### sgn.plot.spec_C_1.png

![](spectrograms/arbitrary-selection/sgn.plot.spec_C_1.png)

---

### sgn.plot.spec_D_268.png

![](spectrograms/arbitrary-selection/sgn.plot.spec_D_268.png)

---

### sgn.plot.spec_E1_1011.png

![](spectrograms/arbitrary-selection/sgn.plot.spec_E1_1011.png)

---

### sgn.plot.spec_EG_1208.png

![](spectrograms/arbitrary-selection/sgn.plot.spec_EG_1208.png)

---

### sgn.plot.spec_E_43.png

![](spectrograms/arbitrary-selection/sgn.plot.spec_E_43.png)

---

### sgn.plot.spec_F_50.png

![](spectrograms/arbitrary-selection/sgn.plot.spec_F_50.png)

---

### sgn.plot.spec_G2_188.png

![](spectrograms/arbitrary-selection/sgn.plot.spec_G2_188.png)

---

### sgn.plot.spec_G2_55.png

![](spectrograms/arbitrary-selection/sgn.plot.spec_G2_55.png)

---

### sgn.plot.spec_G_179.png

![](spectrograms/arbitrary-selection/sgn.plot.spec_G_179.png)

---

### sgn.plot.spec_H_180.png

![](spectrograms/arbitrary-selection/sgn.plot.spec_H_180.png)

---

### sgn.plot.spec_I2_660.png

![](spectrograms/arbitrary-selection/sgn.plot.spec_I2_660.png)

---

### sgn.plot.spec_I3_681.png

![](spectrograms/arbitrary-selection/sgn.plot.spec_I3_681.png)

---

### sgn.plot.spec_I4_1477.png

![](spectrograms/arbitrary-selection/sgn.plot.spec_I4_1477.png)

---

### sgn.plot.spec_I_65.png

![](spectrograms/arbitrary-selection/sgn.plot.spec_I_65.png)

---

### sgn.plot.spec_M_1951.png

![](spectrograms/arbitrary-selection/sgn.plot.spec_M_1951.png)

---

### sgn.plot.spec_P_108.png

![](spectrograms/arbitrary-selection/sgn.plot.spec_P_108.png)
