# coding=utf-8
import pandas as pd
import matplotlib.pyplot as plt


def plot_csv(filename):
    df = pd.read_csv(filename, comment='#')
    # print(df)

    markers = ['o', '*', 's', 'D', '^', '>', '1', '2', '3', '4', '|', '_']
    marker_index = 0

    fig = plt.figure(figsize=(10, 4))
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
    plt.ylabel('Test avg accuracy (%)')
    plt.xlabel('$P$, Prediction Order')

    fig.savefig('scatter-P-vs-testAvgAc.png', bbox_inches='tight')
    # plt.show(block=True)


if __name__ == "__main__":
    from sys import argv
    if len(argv) < 2:
        print('USAGE: scatter-P-vs-testAvgAc.py <csv-filename>')
        exit(1)

    csv_filename = argv[1]
    plot_csv(csv_filename)
