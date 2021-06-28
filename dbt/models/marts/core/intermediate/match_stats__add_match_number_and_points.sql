{{ config(materialized = 'ephemeral') }}

with

unioned as (
    
    select * from {{ ref('match_stats__union_all') }}
    
),

final_cte as (

    select
        *,
        row_number() over(partition by league, team, season order by date asc) as match,
        
        case
            when FTR = 'Win' then 3
            when FTR = 'Draw' then 1
            else 0
        end as points
    
    from unioned
    
)

select * from final_cte