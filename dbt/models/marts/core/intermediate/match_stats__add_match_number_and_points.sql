{{ config(materialized = 'ephemeral') }}

with

unioned as (
    
    select * from {{ ref('match_stats__union_all') }}
    
),

final_cte as (

    select
        *,
        row_number() over(partition by league, team, season order by match_played_on asc) as match_number,
        
        case
            when result_at_full_time = 'Win' then 3
            when result_at_full_time = 'Draw' then 1
            else 0
        end as points_earned
    
    from unioned
    
)

select * from final_cte