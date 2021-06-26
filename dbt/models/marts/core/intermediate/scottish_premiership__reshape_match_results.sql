{% set teams = dbt_utils.get_column_values(
    
    table = ref('stg_scottish_premiership_match_results__recast_and_rename'),
    column = 'home_team'

) %}

with

match_results as (

    select * from {{ ref('stg_scottish_premiership_match_results__recast_and_rename') }}

),

reshaped as (
    
    {% for team in teams %}

    select
        match_id,
        season,
        match_played_on,
        home_team as team,
        away_team as opponent,
        'Home' as location,
        
        case
            when result_at_full_time = 'H' then 'Win'
            when result_at_full_time = 'A' then 'Loss'
            else 'Draw'
        end as result_at_full_time,    
    
        home_goals_at_full_time as goals_for_at_full_time,
        away_goals_at_full_time as goals_against_at_full_time,

        case
            when result_at_half_time = 'H' then 'Winning'
            when result_at_half_time = 'A' then 'Losing'
            else 'Drawing'
        end as result_at_half_time,        
    
        home_goals_at_half_time as goals_for_at_half_time,
        away_goals_at_half_time as goals_against_at_half_time,
        home_shots as shots_for,
        away_shots as shots_against,
        home_shots_on_target as shots_on_target_for,
        away_shots_on_target as shots_on_target_against

    from match_results
    where home_team = '{{ team }}'
    
    union all
    
    select
        match_id,
        season,
        match_played_on,
        away_team as team,
        home_team as opponent,
        'Away' as location,
        
        case
            when result_at_full_time = 'H' then 'Loss'
            when result_at_full_time = 'A' then 'Win'
            else 'Draw'
        end as result_at_full_time,
        
        away_goals_at_full_time as goals_for_at_full_time,
        home_goals_at_full_time as goals_against_at_full_time,
    
        case
            when result_at_half_time = 'H' then 'Losing'
            when result_at_half_time = 'A' then 'Winning'
            else 'Drawing'
        end as result_at_half_time,
        
        away_goals_at_half_time as goals_for_at_half_time,
        home_goals_at_half_time as goals_against_at_half_time,
        away_shots as shots_for,
        home_shots as shots_against,
        away_shots_on_target as shots_on_target_for,
        home_shots_on_target as shots_on_target_against
    
    from match_results
    where away_team = '{{ team }}'
    
    {% if not loop.last %} union all {% endif %}
    {% endfor %}

),  

final_cte as (
    
    select
        *,
        row_number() over(partition by team, season order by match_played_on asc) as match_number
    
    from reshaped
    order by team, season, match_played_on

)

select * from final_cte