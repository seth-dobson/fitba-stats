with

scottish_premiership as (

    select * from {{ ref('stg_scottish_premiership_match_results__recast_and_rename') }}

),

unioned as (
    
    select
        match_id,
        season,
        match_played_on,
        home_team as team,
        away_team as opponent,
        'home' as location
    
    from scottish_premiership
    where home_team = 'Celtic'
    
    union all
    
    select
        match_id,
        season,
        match_played_on,
        away_team as team,
        home_team as opponent,
        'away' as location
    
    from scottish_premiership
    where away_team = 'Celtic'
    
),

final_cte as (
    
    select
        *,
        row_number() over(partition by season order by match_played_on asc) as match_number
    
    from unioned
    order by season, team, match_played_on

)

select * from final_cte