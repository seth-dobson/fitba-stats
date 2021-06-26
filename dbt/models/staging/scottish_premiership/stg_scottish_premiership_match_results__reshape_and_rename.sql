{% set teams = dbt_utils.get_column_values(
    
    table = ref('stg_scottish_premiership_match_results__clean_date'),
    column = 'HomeTeam'

) %}

with

match_results as (

    select * from {{ ref('stg_scottish_premiership_match_results__clean_date') }}

),

home_results as (
    
    {% for team in teams %}
    
    select
        match_id,
        season,
        clean_date as match_played_on,
        HomeTeam as team,
        AwayTeam as opponent,
        'Home' as location,
        
        case
            when FTR = 'H' then 'Win'
            when FTR = 'A' then 'Loss'
            else 'Draw'
        end as result_at_full_time,    
    
        FTHG as goals_for_at_full_time,
        FTAG as goals_against_at_full_time,

        case
            when HTR = 'H' then 'Winning'
            when HTR = 'A' then 'Losing'
            else 'Drawing'
        end as result_at_half_time,        
    
        HTHG as goals_for_at_half_time,
        HTAG as goals_against_at_half_time,
        
        HS as shots_for,
        away_shots as shots_against,
        
        HST as shots_on_target_for,
        AST as shots_on_target_against

    from match_results
    where HomeTeam = '{{ team }}'
    
    {% if not loop.last %} union all {% endif %}
    {% endfor %}

),
    
away_results as (
    
    {% for team in teams %}
    
    select
        match_id,
        season,
        clean_date as match_played_on,
        AwayTeam as team,
        HomeTeam as opponent,
        'Away' as location,
        
        case
            when FTR = 'H' then 'Loss'
            when FTR = 'A' then 'Win'
            else 'Draw'
        end as result_at_full_time,
        
        FTAG as goals_for_at_full_time,
        FTHG as goals_against_at_full_time,
    
        case
            when HTR = 'H' then 'Losing'
            when HTR = 'A' then 'Winning'
            else 'Drawing'
        end as result_at_half_time,
        
        HTAG as goals_for_at_half_time,
        HTHG as goals_against_at_half_time,
        
        away_shots as shots_for,
        HS as shots_against,
            
        AST as shots_on_target_for,
        HST as shots_on_target_against
    
    from match_results
    where AwayTeam = '{{ team }}'
    
    {% if not loop.last %} union all {% endif %}
    {% endfor %}

),  

final_cte as (
    
    select 
        *,
        'Scottish Premiership' as league,
    
    from home_results
    
    union all
    
    select 
        *,
        'Scottish Premiership' as league,
    
    from away_results

)

select * from final_cte