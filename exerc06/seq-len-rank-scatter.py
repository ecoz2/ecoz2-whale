import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from subprocess import Popen, PIPE
import re


def get_seq_len(seq_filename):
    process = Popen(['ecoz2', 'seq', 'show', seq_filename], stdout=PIPE, stderr=PIPE)
    stdout, _ = process.communicate()
    search = re.search(br'L=(.+)\)', stdout)
    return int(search.group(1))


def get_seq_lens(c12n_df):
    seq_filenames = []
    seq_lens = []
    for seq_filename in c12n_df['seq_filename']:
        seq_filenames.append(seq_filename)
        seq_lens.append(get_seq_len(seq_filename))

    return pd.DataFrame({
      'seq_filename': seq_filenames,
      'seq_length': seq_lens
    })


def plot_seq_len_rank_scatter(c12n_df, lens_df):
    title = 'Sequence Classification Rank vs. Length'
    ranks = c12n_df['rank']
    lens = lens_df['seq_length']
    fig = plt.figure()
    ax = fig.add_subplot(111)
    ax.set_xlabel('Sequence Length')
    ax.set_ylabel('Rank')
    ax.scatter(lens, ranks, color='black', alpha=.3, marker='o')
    plt.title(title)
    # plt.show(block=True)
    fig.tight_layout()
    fig.savefig('seq-len-rank-scatter.png')


if __name__ == "__main__":
    import sys
    if len(sys.argv) == 3:
        c12n_filename = sys.argv[1]
        lens_filename = sys.argv[2]
        c12n_df = pd.read_csv(c12n_filename, comment='#')
        try:
            lens_df = pd.read_csv(lens_filename, comment='#')
        except:
            print('getting sequence lengths')
            lens_df = get_seq_lens(c12n_df)
            lens_df.to_csv(lens_filename, index=False, sep=',', encoding='utf-8')

        print('plotting')
        plot_seq_len_rank_scatter(c12n_df, lens_df)
    else:
        print('''
          USAGE: seq-len-rank-scatter.py <c12n_filename> <lens_filename>
          (<lens_filename> is created if non-exisitent)
          ''')
