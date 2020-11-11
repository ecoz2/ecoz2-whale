import pandas as pd
import plotly.express as px
import plotly.graph_objects as go
import numpy as np


def do_plot(csv_filename, show_train):
    summary = pd.read_csv(csv_filename)

    dimensions = []

    def add_m_dimension(values):
        log2_values = np.log2(values)
        tickvals = np.sort(values.unique())
        ticktext = [str(int(u)) for u in tickvals]
        # print('tickvals={}\nlog2={}\nticktext={}'.format(tickvals, np.log2(tickvals), ticktext))
        d = dict(
          range = [log2_values.min(), log2_values.max()],
          label = 'M (log scale)',
          tickvals = np.log2(tickvals),
          ticktext = ticktext,
          values = log2_values
        )
        dimensions.append(d)

    def add_other_dimension(label, values, range=None):
        range = range or [values.min(), values.max()]
        # print('range={}  label={}'.format(range, label))
        d = dict(
          label = label,
          range = range,
          values = values
        )
        if label != 'Test avgAc' and label != 'Train avgAc':
            d['tickvals'] = values.unique()
        dimensions.append(d)

    test_avg_ac = summary['Test avgAc']

    # when also showing 'Train avgAc', a common `range` for this one
    # and 'Test avgAc' helps with the visualization
    range = None

    def add_train_if_so_desired():
      if show_train:
          train_avg_ac = summary['Train avgAc']
          range_min = min(train_avg_ac.min(), test_avg_ac.min())
          range_max = max(train_avg_ac.max(), test_avg_ac.max())
          if range_max >= 97:
              range_max = 100
          range = [range_min, range_max]
          # print('range={}'.format(range))
          add_other_dimension('Train avgAc', train_avg_ac, range)
          return range

    if csv_filename == 'nb-summary.csv':
        if 'P' in summary:
            add_other_dimension('P', summary['P'])
        add_m_dimension(summary['M'])
        range = add_train_if_so_desired()

    elif csv_filename == 'hmm-summary.csv':
        add_other_dimension('N', summary['N'])
        add_m_dimension(summary['M'])
        add_other_dimension('I', summary['I'])
        range = add_train_if_so_desired()

    else:
        print(f'unrecognized file: {csv_filename}')
        return

    add_other_dimension('Test avgAc', test_avg_ac, range)

    fig = go.Figure(data=go.Parcoords(
        line = dict(
          color = test_avg_ac,
          colorscale = 'Picnic',
          showscale = True,
        ),
        dimensions = dimensions,
    ))

    # fig.write_image('summary-parallel.png')
    fig.show()


if __name__ == "__main__":
    import sys
    if 2 <= len(sys.argv) <= 3:
        show_train = len(sys.argv) == 3 and sys.argv[2] == 'show-train'
        do_plot(sys.argv[1], show_train)
    else:
        print('USAGE: summary-parallel.py <csv-filename> [show-train]')
