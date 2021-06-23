with

scottish_premiership as (

    select * from {{ ref('stg_scottish_premiership_match_results__union_all') }}

),

final_cte as (

    select
        match_id,
        season,
    
        parse_date('%d/%m/%Y', Date) as match_played_on,
        
        HomeTeam as home_team,
        AwayTeam as away_team,
        FTR as result_at_full_time,
        FTHG as home_goals_at_full_time,
        FTAG as away_goals_at_full_time,
        HTR as result_at_half_time,
        HTHG as home_goals_at_half_time,
        HTAG as away_goals_at_half_time,
        HS as home_shots,
        away_shots, --name changed prior to loading
        HST as home_shots_on_target,
        AST as away_shots_on_target,
        HC as home_corners,
        AC as away_corners,
        HF as home_fouls,
        AF as away_fouls,
        HY as home_yellow_cards,
        AY as away_yellow_cards,
        HR as home_red_cards,
        AR as away_red_cards
    
    from scottish_premiership

)

select * from final_cte