# coding=utf-8
import pandas as pd
import matplotlib.pyplot as plt

# RUN:
#   python3 ./hmm-scatter.py hmm-summary-t0.csv


def plot_csv(filename):
    df = pd.read_csv(filename, comment='#')
    # print(df)

    # just enough markers (we don't have many different M values)
    markers = ['o', '*', 's', 'D', '^', '>', '1', '2', '3', '4', '|', '_']
    marker_index = 0

    fig = plt.figure(figsize=(8, 4))

    # only consider I=1
    rows_by_I = df.loc[df['I'] == 1]

    for m in [4096, 2048, 1024, 512]:
      rows = rows_by_I.loc[rows_by_I['M'] == m]
      ns = rows['N']
      avgAcs = rows['Test avgAc']

      plt.plot(ns, avgAcs, linestyle='--')
      plt.scatter(ns, avgAcs, label='$M={}$'.format(m), marker=markers[marker_index])
      marker_index += 1
      plt.xticks(ns)
      plt.grid(True)

    # plt.title(title)
    plt.legend(loc='best')  # lower right
    plt.ylabel('Average accuracy on test data (%)')
    plt.xlabel('$N$, Number of states')
    plt.title('HMM Classification Accuracy for various values of $N$ and $M$')

    fig.savefig('hmm-scatter.png', bbox_inches='tight')
    # plt.show(block=True)


if __name__ == "__main__":
    from sys import argv
    if len(argv) < 2:
        print('USAGE: scatter-P-vs-testAvgAc.py <csv-filename>')
        exit(1)

    csv_filename = argv[1]
    plot_csv(csv_filename)
