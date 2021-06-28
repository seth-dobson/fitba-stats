with

celtic_matches as (

    select * from {{ ref('celtic_matches') }}
    
),

final_cte as (

    select
        season,
        max(match) as MP,
        round(avg(points), 1) as points,
        
        round(avg(SF), 1) as SF,
        round(avg(SA), 1) as SA,
        round(avg(SoTF), 1) as SoTF,
        round(avg(SoTA), 1) as SoTA,
        round(avg(FTGF), 1) as GF,
        round(avg(FTGA), 1) as GA,

        round(100 * (sum(SF) / (sum(SF) + sum(SA))), 1) as shot_share,
        round(100 * (sum(SoTF) / (sum(SoTF) + sum(SoTA))), 1) as SoT_share,
        round(100 * (sum(FTGF) / (sum(FTGF) + sum(FTGA))), 1) as goal_share,
        round(100 * (sum(FTGF) / sum(SoTF)), 1) as score_pct,
        round(100 * (1 - (sum(FTGA) / sum(SoTA))), 1) as save_pct,
        round(100 * ((sum(FTGF) / sum(SoTF)) + (1 - (sum(FTGA) / sum(SoTA)))), 1) as PDO
    
    from celtic_matches
    
    group by 1

)

select *

from final_cte
order by season