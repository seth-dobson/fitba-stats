with

scottish_premiership as (

    select * from {{ ref('stg_scottish_premiership_match_results__union_all') }}

),

final_cte as (

    select
        match_id,
        season,
    
        parse_date('%d/%m/%Y', Date) as match_played_on,
        
        HomeTeam as home_team_name,
        AwayTeam as away_team_name,
        FTR as result_at_full_time,
        FTHG as home_goals_at_full_time,
        FTAG as away_goals_at_full_time,
        HTR as result_at_half_time,
        HTHG as home_goals_at_half_time,
        HTAG as away_goals_at_half_time
    
    from scottish_premiership

)

select * from final_cte