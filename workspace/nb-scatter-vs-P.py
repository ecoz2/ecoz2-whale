# coding=utf-8
import pandas as pd
import matplotlib.pyplot as plt

# RUN:
#   python3 ./nb-scatter-vs-P.py nb-summary.csv


def plot_csv(filename):
    df = pd.read_csv(filename, comment='#')
    # print(df)

    # just enough markers (we don't have many different M values)
    markers = ['o', '*', 's', 'D', '^', '>', '1', '2', '3', '4', '|', '_']
    marker_index = 0

    fig = plt.figure(figsize=(16, 4))

    # for m in [4096, 2048, 1024, 512, 256, 128, 64, 32]:
    for m in [4096, 2048, 1024, 512]:
      rows = df.loc[df['M'] == m]
      orders = rows['P']
      avgAcs = rows['Test avgAc']

      plt.plot(orders, avgAcs, linestyle='--')
      plt.scatter(orders, avgAcs, label='$M={}$'.format(m), marker=markers[marker_index])
      marker_index += 1
      plt.xticks(orders)
      plt.grid(True)

    # plt.title(title)
    plt.legend(loc='best')  # lower right
    plt.ylabel('Average accuracy on test data (%)')
    plt.xlabel('$P$, Prediction Order')
    plt.title('N-Bayes Classification Accuracy for various values of $P$ and $M$')

    fig.savefig('nb-scatter-vs-P.png', bbox_inches='tight')
    # plt.show(block=True)


if __name__ == "__main__":
    from sys import argv
    if len(argv) < 2:
        print('USAGE: nb-scatter-vs-P.py <csv-filename>')
        exit(1)

    csv_filename = argv[1]
    plot_csv(csv_filename)
