# coding=utf-8
import pandas as pd
import matplotlib.pyplot as plt

# RUN:
#   python3 ./mm-scatter.py mm-summary.csv


def plot_csv(filename):
    df = pd.read_csv(filename, comment='#')
    # print(df)

    fig = plt.figure(figsize=6, 4))

    ms = df['M']
    avgAcs = df['Test avgAc']

    plt.plot(ms, avgAcs, linestyle='--')
    plt.scatter(ms, avgAcs, label='$M$')

    plt.ylabel('Average accuracy on test data (%)')
    plt.xlabel('$M$, Codebook size (log scale)')
    plt.xscale('log')
    plt.xticks(ms, labels=['{:3}'.format(m) for m in ms])
    plt.grid(True)
    plt.title('Markov Chain Classification Accuracy')

    fig.savefig('mm-scatter.png', bbox_inches='tight')
    # plt.show(block=True)


if __name__ == "__main__":
    from sys import argv
    if len(argv) < 2:
        print('USAGE: mm-scatter.py <csv-filename>')
        exit(1)

    csv_filename = argv[1]
    plot_csv(csv_filename)
