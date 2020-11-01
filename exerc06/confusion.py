#!/usr/bin/env python3

import json
import pandas as pd
import numpy as np
from sklearn.metrics import confusion_matrix, classification_report
import matplotlib.pyplot as plt
import seaborn as sns

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


# adapted (hastily) from https://gist.github.com/hitvoice/36cf44689065ca9b927431546381a3f7
def cm_analysis(cm=None, y_true=None, y_pred=None, labels=None, ymap=None, figsize=(10,10), filename=None):
    """
    Generate matrix plot of confusion matrix with pretty annotations.
    The plot image is saved to disk.
    args:
      cm:        confusion matrix if already available
      y_true:    true label of the data, with shape (nsamples,)
      y_pred:    prediction of the data, with shape (nsamples,)
      labels:    string array, name the order of class labels in the confusion matrix.
                 use `clf.classes_` if using scikit-learn models.
                 with shape (nclass,).
      ymap:      dict: any -> string, length == nclass.
                 if not None, map the labels & ys to more understandable strings.
                 Caution: original y_true, y_pred and labels must align.
      figsize:   the size of the figure plotted.
      filename:  filename of figure file to save
    """
    if cm is None:
      if ymap is not None:
          y_pred = [ymap[yi] for yi in y_pred]
          y_true = [ymap[yi] for yi in y_true]
          labels = [ymap[yi] for yi in labels]
      cm = confusion_matrix(y_true, y_pred, labels=labels)

    cm_sum = np.sum(cm, axis=1, keepdims=True)
    cm_perc = cm / cm_sum.astype(float) * 100
    annot = np.empty_like(cm).astype(str)
    nrows, ncols = cm.shape
    for i in range(nrows):
        for j in range(ncols):
            c = cm[i, j]
            p = cm_perc[i, j]
            if i == j:
                s = cm_sum[i]
                annot[i, j] = '%.1f%%\n%d/%d' % (p, c, s)
            elif c == 0:
                annot[i, j] = ''
            else:
                annot[i, j] = '%.1f%%\n%d' % (p, c)
    cm = pd.DataFrame(cm, index=labels, columns=labels)
    cm.index.name = 'Actual'
    cm.columns.name = 'Predicted'
    fig, ax = plt.subplots(figsize=figsize)
    sns.heatmap(cm, annot=annot, fmt='', ax=ax)
    if filename:
      plt.savefig(filename)


def plot_confusion_matrix_using_plt(cm):
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


def plot_confusion_matrix(cm):
  cm_analysis(cm=cm, filename='confusion.png')
  # plot_confusion_matrix_using_plt(cm)


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
  cm = confusion_matrix(y_true, y_pred)
  print(cm)

  print('\nclassification report:')
  print(classification_report(y_true, y_pred, digits=4))

  if args.plot_confusion:
    plot_confusion_matrix(cm)

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
