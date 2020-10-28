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
    seq_class_names = []
    seq_lens = []
    for i in range(len(c12n_df)) :
        seq_filename = c12n_df.loc[i, 'seq_filename']
        seq_class_name = c12n_df.loc[i, 'seq_class_name']
        seq_filenames.append(seq_filename)
        seq_class_names.append(seq_class_name)
        seq_lens.append(get_seq_len(seq_filename))

    return pd.DataFrame({
      'seq_filename': seq_filenames,
      'seq_class_name': seq_class_names,
      'seq_length': seq_lens
    })

if __name__ == "__main__":
    import sys
    if len(sys.argv) == 3:
        c12n_filename = sys.argv[1]
        lens_filename = sys.argv[2]
        c12n_df = pd.read_csv(c12n_filename, comment='#')
        print('getting sequence lengths')
        lens_df = get_seq_lens(c12n_df)
        lens_df.to_csv(lens_filename, index=False, sep=',', encoding='utf-8')
    else:
        print('''
          USAGE: seq-len-extract.py <c12n_filename> <lens_filename>
          ''')
