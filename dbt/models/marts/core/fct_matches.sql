with

match_stats as (
    
    select * from {{ ref('match_stats__add_match_number_and_points') }}
    
),

final_cte as (

    select
        league,
        team,
        season,
        match,
        date,
        opponent,
        location,
        FTR,
        points,
        FTGF,
        FTGA,
        HTR,
        HTGF,
        HTGA,
        SF,
        SA,
        SoTF,
        SoTA,
        match_id
    
    from match_stats
    
)

select * 

from final_cte
order by league, team, season, match