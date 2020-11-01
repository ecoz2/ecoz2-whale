#!/usr/bin/env python3

import pickle
from sklearn import metrics


def main():
  with open('y_true_pred_TODO.pickle', 'rb') as f:
    y_true_pred = pickle.load(f)

  # print('y_true_pred=\n{}'.format(y_true_pred))

  y_true = y_true_pred['y_true']
  y_pred = y_true_pred['y_pred']

  print('\nconfusion matrix:')
  print(metrics.confusion_matrix(y_true, y_pred))

  print('\nclassification report:')
  print(metrics.classification_report(y_true, y_pred, digits=3))


if __name__ == "__main__":
  main()
