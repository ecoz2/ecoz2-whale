import pandas as pd
import plotly.express as px
import plotly.graph_objects as go
import numpy as np


def do_plot(csv_filename):
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

    def add_other_dimension(label, values):
        d = dict(
          label = label,
          range = [values.min(), values.max()],
          values = values
        )
        if label != 'Test avgAc':
            d['tickvals'] = values.unique()
        dimensions.append(d)

    # the regular hmm-generated:
    if csv_filename == 'hmm-summary.csv':
        # selection = summary[['N', 'M', 'I', 'Test avgAc']]
        add_other_dimension('N', summary['N'])
        # add_other_dimension('M', summary['M'])
        add_m_dimension(summary['M'])
        add_other_dimension('I', summary['I'])

    # ad hoc for other tests:
    elif csv_filename == 'nb-summary.csv' or \
         csv_filename == 'vq-summary.csv':
        selection = summary[['M', 'Test avgAc']]
        add_m_dimension(summary['M'])

    elif csv_filename == 'mm-summary.csv':
        selection = summary[['M', 'Train avgAc', 'Test avgAc']]
        add_m_dimension(summary['M'])

    else:
        print(f'unrecognized file: {csv_filename}')
        return

    add_other_dimension('Test avgAc', summary['Test avgAc'])

    fig = go.Figure(data=go.Parcoords(
        line = dict(
          color = summary['Test avgAc'],
          colorscale = 'Picnic',
          showscale = True,
        ),
        dimensions = dimensions,
    ))

    # fig = px.parallel_coordinates(selection,
    #                               color='Test avgAc',
    #                               color_continuous_scale=px.colors.diverging.Picnic
    #                               )

    # fig.write_image('summary-parallel.png')
    fig.show()


if __name__ == "__main__":
    import sys
    if len(sys.argv) == 2:
        do_plot(sys.argv[1])
    else:
        print('USAGE: summary-parallel.py <csv-filename>')
