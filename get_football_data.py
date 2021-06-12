# script to get match results from football-data.co.uk
# run in terminal using `python get_football_data.py`

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
    '0203',
    '0102',
    '0001'
    
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

    df.to_csv(
        
        f'~/fitba-stats/dbt/data/src_football_data_scottish_premiership_match_results_{season}.csv', 
        
        index = False, 
        encoding = 'utf-8'
        
    )