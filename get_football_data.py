'''
script to get match results from football-data.co.uk
run in terminal using `python get_football_data.py`
'''

import pandas as pd

seasons = [
    
    '2021',
    '1920',
    '1819',
    '1718',
    '1617',
    '1516',
    '1415',
    '1314',
    '1213',
    '1112',
    '1011',
    '0910',
    '0809',
    '0708',
    '0607',
    '0506',
    '0405',
    '0304',
    '0102'
    
]

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
    'AST'
    
]

for season in seasons:

    df = pd.read_csv(
        
        f'https://www.football-data.co.uk/mmz4281/{season}/SC0.csv',
        
        engine = 'python',
        encoding = 'iso-8859-1',
        usecols = columns
    
    )
    
    df['HS'] = pd.to_numeric(df['HS'], errors = 'coerce').astype('Int64')
    df['AS'] = pd.to_numeric(df['AS'], errors = 'coerce').astype('Int64')
    df['HST'] = pd.to_numeric(df['HST'], errors = 'coerce').astype('Int64')
    df['AST'] = pd.to_numeric(df['AST'], errors = 'coerce').astype('Int64')
    
    df.to_csv(
        
        f'~/fitba-stats/dbt/data/src_football_data_scottish_premiership_match_results_{season}.csv', 
        
        index = False, 
        encoding = 'utf-8'
        
    )