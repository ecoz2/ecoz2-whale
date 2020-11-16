# coding=utf-8
import pandas as pd
import matplotlib.pyplot as plt

# RUN:
#   python3 ./vq-scatter-vs-P.py vq-summary.csv


def plot_csv(df, do_zoom):
    # just enough markers (we don't have many different M values)
    markers = ['o', '*', 's', 'D', '^', '>', '1', '2', '3', '4', '|', '_']
    marker_index = 0

    if do_zoom:
      selected_rows = df.loc[df['P'] > 20]
      fig = plt.figure(figsize=(7, 3))
      ms = [4096, 2048, 1024, 512, 256]
    else:
      selected_rows = df
      fig = plt.figure(figsize=(7, 7))
      ms = [4096, 2048, 1024, 512, 256, 128, 64, 32, 16, 8, 4, 2]

    for m in ms:
      rows = selected_rows.loc[selected_rows['M'] == m]
      orders = rows['P']
      avgAcs = rows['Test avgAc']

      plt.plot(orders, avgAcs, linestyle='--')
      plt.scatter(orders, avgAcs, label='$M={}$'.format(m), marker=markers[marker_index])
      marker_index += 1
      plt.xticks(orders)
      plt.grid(True)

    if not do_zoom:
      plt.legend(loc='best', ncol=3,)  # lower right

    plt.ylabel('Average accuracy on test data (%)')
    plt.xlabel('$P$, Prediction Order')
    plt.title('VQ Classification Accuracy')

    filename = 'vq-scatter-vs-P{}.png'.format('_zoom' if do_zoom else '')
    fig.savefig(filename, bbox_inches='tight')
    # plt.show(block=True)


if __name__ == "__main__":
    from sys import argv
    if len(argv) < 2:
        print('USAGE: vq-scatter-vs-P.py <csv-filename>')
        exit(1)

    csv_filename = argv[1]
    df = pd.read_csv(csv_filename, comment='#')
    # print(df)

    plot_csv(df, do_zoom=True)
    plot_csv(df, do_zoom=False)
