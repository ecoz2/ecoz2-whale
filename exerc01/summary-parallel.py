import pandas as pd
import plotly.express as px

summary = pd.read_csv('summary.csv')
selection = summary[['N', 'M', 'I', 'Test avgAc']]
fig = px.parallel_coordinates(selection,
                              color='Test avgAc',
                              color_continuous_scale=px.colors.diverging.Picnic
                              )

# fig.write_image('summary-parallel.png')
fig.show()
