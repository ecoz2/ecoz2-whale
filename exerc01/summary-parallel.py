import pandas as pd
import plotly.express as px


def do_plot(csv_filename):
    summary = pd.read_csv(csv_filename)

    # the regular hmm-generated:
    if csv_filename == 'summary.csv':
        selection = summary[['N', 'M', 'I', 'Test avgAc']]

    # ad hoc for other tests:
    elif csv_filename == 'summary-nbayes.csv':
        selection = summary[['M', 'Test avgAc']]

    else:
        print('unrecognized file: {}'.format(csv_filename))
        return

    fig = px.parallel_coordinates(selection,
                                  color='Test avgAc',
                                  color_continuous_scale=px.colors.diverging.Picnic
                                  )

    # fig.write_image('summary-parallel.png')
    fig.show()


if __name__ == "__main__":
    import sys
    if len(sys.argv) == 2:
        do_plot(sys.argv[1])
    else:
        print('USAGE: summary-parallel.py <csv-filename>')
