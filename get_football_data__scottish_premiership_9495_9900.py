'''
script to get Scottish Premiership match stats 
from football-data.co.uk for seasons 1994-95 to 1999-2000
'''

import pandas as pd

seasons = [
    
    '9495',
    '9596',
    '9697',
    '9798',
    '9899',
    '9900'
    
]

columns = [
    
    'Date',
    'HomeTeam',
    'AwayTeam',
    'FTHG',
    'FTAG',
    'FTR'
    
]

int_cols = [
    
    'FTHG',
    'FTAG'

]

def coerce_int64(column):
    
    df[column] = pd.to_numeric(df[column], errors = 'coerce').astype('Int64')

for season in seasons:

    df = pd.read_csv(
        
        f'https://www.football-data.co.uk/mmz4281/{season}/SC0.csv',
        
        engine = 'python',
        encoding = 'iso-8859-1',
        usecols = columns,
        nrows = 180
    
    )
    
    for column in int_cols:
        
        coerce_int64(column)
    
    df.rename(columns = {'AS': 'away_shots'}, inplace = True)
    
    df.to_csv(
        
        f'~/fitba-stats/dbt/data/seed_football_data_scottish_premiership_match_results_{season}.csv', 
        
        index = False, 
        encoding = 'utf-8'
        
    )