with

match_stats as (
    
    select * from {{ ref('match_stats__add_match_number') }}
),

final_cte as (

    select
        league,
        team,
        season,
        match_number,
        match_played_on,
        opponent,
        location,
        result_at_full_time,
        goals_for_at_full_time,
        goals_against_at_full_time,
        result_at_half_time,
        goals_for_at_half_time,
        goals_against_at_half_time,
        shots_for,
        shots_against,
        shots_on_target_for,
        shots_on_target_against,
        match_id
    
    from match_stats
    
)

select * from final_cte