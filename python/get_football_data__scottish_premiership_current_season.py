'''
script to get Scottish Premiership match stats 
from football-data.co.uk for curren season
'''

import pandas as pd

season = '2122'

columns = [
    
    'Date',
    'HomeTeam',
    'AwayTeam',
    'FTHG',
    'FTAG',
    'FTR',
    'HTHG',
    'HTAG',
    'HTR',
    'HS',
    'AS',
    'HST',
    'AST',
    'HF',
    'AF',
    'HC',
    'AC',
    'HY',
    'AY',
    'HR',
    'AR'
    
]

int_cols = [
    
    'FTHG',
    'FTAG',
    'HTHG',
    'HTAG',
    'HS',
    'AS',
    'HST',
    'AST',
    'HF',
    'AF',
    'HC',
    'AC',
    'HY',
    'AY',
    'HR',
    'AR'

]

def coerce_int64(column):
    
    df[column] = pd.to_numeric(df[column], errors = 'coerce').astype('Int64')

df = pd.read_csv(

    f'https://www.football-data.co.uk/mmz4281/{season}/SC0.csv',

    engine = 'python',
    encoding = 'iso-8859-1',
    usecols = columns

)
    
for column in int_cols:
    
    coerce_int64(column)

df.rename(columns = {'AS': 'away_shots'}, inplace = True)

df.to_csv(

    f'~/fitba-stats/dbt/data/seed_football_data_scottish_premiership_match_results_{season}.csv', 

    index = False, 
    encoding = 'utf-8'

)