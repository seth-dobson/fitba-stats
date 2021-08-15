--set recent seasons to accomodate new date format
{% set recent_seasons = (
    
    '2018-19',
    '2019-20',
    '2020-21',
    '2021-22'

) %}

with

match_results as (

    select * from {{ ref('stg_scottish_premiership_match_results__union_all') }}

),

final_cte as (

    select
        *,
        parse_date('%d/%m/%y', Date) as clean_date
    
    from match_results
    where season not in {{ recent_seasons }}
    
    union all
    
    select
        *,
        parse_date('%d/%m/%Y', Date) as clean_date
    
    from match_results
    where season in {{ recent_seasons }}
    
)

select * from final_cte