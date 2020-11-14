## HMM

Getting confusion matrix, classification report, MCC:

E.g with `N = 9`:

      ../../exerc06/confusion.py --source c12n/TEST/N9__M4096_t3__a0_I0.csv

      ...
      classification report:
                    precision    recall  f1-score   support

                 A     0.9533    0.9903    0.9714       103
                Bm     1.0000    0.8525    0.9204       122
                 C     0.9550    0.9636    0.9593       110
                 E     0.9612    0.8671    0.9118       143
                 F     0.9571    0.9853    0.9710        68
                G2     0.8841    0.9839    0.9313        62
                I3     0.7176    0.9385    0.8133        65
                II     0.9149    0.9072    0.9110       237

          accuracy                         0.9231       910
         macro avg     0.9179    0.9360    0.9237       910
      weighted avg     0.9297    0.9231    0.9239       910

      MCC = 0.9100955474778509

## MM

      ../../exerc06/confusion.py --source mm_4096_y_true_pred.json
      ...
      classification report:
                    precision    recall  f1-score   support

                 A     0.9266    0.9806    0.9528       103
                Bm     0.8571    0.8852    0.8710       122
                 C     0.8934    0.9909    0.9397       110
                 E     0.8690    0.8811    0.8750       143
                 F     0.8701    0.9853    0.9241        68
                G2     0.8026    0.9839    0.8841        62
                I3     0.8667    0.8000    0.8320        65
                II     0.9487    0.7806    0.8565       237

          accuracy                         0.8890       910
         macro avg     0.8793    0.9110    0.8919       910
      weighted avg     0.8930    0.8890    0.8875       910

      MCC = 0.8714694386008479

## N-Bayes
