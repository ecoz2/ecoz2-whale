#!/usr/bin/env python3

import json
import pandas as pd
from sklearn import metrics
import matplotlib.pyplot as plt

# ./confusion.py c12n/TEST/N3__M2048_t3__a0.3_I1.csv
# ./confusion.py y_true_pred_TODO.json


def from_csv(filename: str):
  c12n = pd.read_csv(filename, comment='#', sep=',')
  y_true = []
  y_pred = []
  for i, c12n_row in c12n.iterrows():
    class_name = c12n_row.get('seq_class_name')
    r1 = c12n_row.get('r1')

    y_true.append(class_name)
    y_pred.append(r1)

  return dict(y_true=y_true, y_pred=y_pred)

def main(args):
  if args.source.endswith('.csv'):
    y_true_pred = from_csv(args.source)
  else:
    with open(args.source, 'rb') as f:
        y_true_pred = json.load(f)

  # print('y_true_pred=\n{}'.format(y_true_pred))

  y_true = y_true_pred['y_true']
  y_pred = y_true_pred['y_pred']

  print('\nconfusion matrix:')
  cm = metrics.confusion_matrix(y_true, y_pred)
  print(cm)

  print('\nclassification report:')
  print(metrics.classification_report(y_true, y_pred, digits=4))

  if args.plot_confusion:
    # https://vitalflux.com/micro-average-macro-average-scoring-metrics-multi-class-classification-python/
    fig, ax = plt.subplots(figsize=(6, 6))
    ax.matshow(cm, cmap=plt.cm.Oranges, alpha=0.3)
    for i in range(cm.shape[0]):
        for j in range(cm.shape[1]):
            ax.text(x=j, y=i, s=cm[i, j], va='center', ha='center', size='xx-large')

    plt.xlabel('Predicted', fontsize=18)
    plt.ylabel('Actuals', fontsize=18)
    plt.title('Confusion Matrix', fontsize=18)
    plt.show()


def parse_args():
    import argparse

    parser = argparse.ArgumentParser(
        description='confusion',
        formatter_class=argparse.RawTextHelpFormatter
    )

    parser.add_argument('--source', required=True)
    parser.add_argument('--plot-confusion', action='store_true')
    parser.add_argument('--verbose', action='store_true')

    return parser.parse_args()


if __name__ == "__main__":
  main(parse_args())
