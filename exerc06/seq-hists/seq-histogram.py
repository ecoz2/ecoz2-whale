import pandas as pd
import numpy as np
import matplotlib.pyplot as plt


def do_plot(df, class_name):
    bins = 70

    if class_name:
        df = df.loc[df['seq_class_name'] == class_name]
        class_str = class_name
    else:
        class_str = 'ALL'

    n = len(df)
    lengths = df['seq_length']
    mean = lengths.mean()
    min = lengths.min()
    max = lengths.max()

    print('{:3}: n={:4} mean={:5.1f} min={:5.1f} max={:5.1f}'.format(
      class_str, n, mean, min, max))

    df.hist(bins=bins)
    plt.grid(axis='y', alpha=0.85)
    plt.xlabel('Length')
    plt.ylabel('Frequency')
    legend = r'$n={}, \mu={:.1f}, b={}$'.format(n, mean, bins)
    title = 'Sequence Length Histogram'
    if class_name:
        title += '(class: {})'.format(class_name)
    title += '\n{}'.format(legend)
    plt.title(title)
    # plt.text(10, 1, legend)
    plt.gca().set_xbound(0, 320)
    # plt.show()

    png_filename = 'seq-hists/{}-histogram.png'.format(class_str)
    plt.savefig(png_filename, dpi=120)


if __name__ == "__main__":
    import sys
    if len(sys.argv) == 2:
        csv_filename = sys.argv[1]
        df = pd.read_csv(csv_filename)

        #  all:
        do_plot(df, None)

        # per class:
        for seq_class_name in df['seq_class_name'].unique():
            do_plot(df, seq_class_name)
    else:
        print('USAGE: seq-histogram.py <csv-filename> [<class>]')
