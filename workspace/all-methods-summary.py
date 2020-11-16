import matplotlib.pyplot as plt
import numpy as np


def do_plot():
  fig = plt.figure(figsize=(5, 3))
  x = [1, 2, 3, 4]
  error = [3.99, 5.94, 8.8, 5.32]
  plt.yticks(error, ['{:.3g}%'.format(e) for e in error])
  plt.ylim([0, 10])
  # plt.ylabel('Average error')

  plt.bar(x, error)
  plt.xticks(x, ['VQ\n(512)', 'N-Bayes\n(4096)', 'M-Chain\n(512)', 'HMM\n(14, 4096)'])
  plt.grid(True, axis='y')
  plt.title('Classification Error Summary ($P=120$)')

  fig.savefig('all-methods-summary.png', bbox_inches='tight')
  # fig.show()


if __name__ == "__main__":
    do_plot()
