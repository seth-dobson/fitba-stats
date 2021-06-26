{{ config(materialized = 'ephemeral') }}

with

unioned as (
    
    select * from {{ ref('match_stats__union_all') }}
    
),

final_cte as (

    select
        *,
        row_number() over(partition by league, team, season order by match_played_on asc) as match_number
    
    from unioned
    order by league, team, season, match_played_on
    
)

select * from final_cte