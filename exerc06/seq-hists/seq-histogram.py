import pandas as pd
import numpy as np
import matplotlib.pyplot as plt


def do_plot(csv_filename, class_name):
    bins = 70

    df = pd.read_csv(csv_filename)
    n = len(df)
    mean = df['length'].mean()

    # print(df)
    print('{}: n={} mean={:.1f}'.format(csv_filename, n, mean))

    df.hist(bins=bins)
    plt.grid(axis='y', alpha=0.85)
    plt.xlabel('Length')
    plt.ylabel('Frequency')
    plt.title('Sequence Length Histogram (class: {})'.format(class_name))
    plt.text(50, 20, r'$n={}, \mu={:.1f}, b={}$'.format(n, mean, bins))
    # plt.show()

    png_filename = '{}-histogram.png'.format(csv_filename)
    plt.savefig(png_filename, dpi=120)


if __name__ == "__main__":
    import sys
    if len(sys.argv) == 3:
        do_plot(sys.argv[1], sys.argv[2])
    else:
        print('USAGE: seq-histogram.py <csv-filename> <class>')
