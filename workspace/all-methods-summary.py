import matplotlib.pyplot as plt
import numpy as np


def do_plot():
  fig = plt.figure(figsize=(8, 4))
  x = [1, 2, 3]
  error = [5.94, 8.8, 5.32]
  plt.yticks(error, ['{:.3g}'.format(e) for e in error])
  plt.ylim([0, 9])
  plt.ylabel('Average accuracy error (%)')

  plt.bar(x, error)
  plt.xticks(x, ['B-Bayes', 'M-Chain', 'HMM'])

  plt.title('Classification Accuracy Error Summary')

  fig.savefig('all-methods-summary.png', bbox_inches='tight')
  # fig.show()


if __name__ == "__main__":
    do_plot()
