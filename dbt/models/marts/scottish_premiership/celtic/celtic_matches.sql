with

celtic_matches as (

    select * 
    
    from {{ ref('fct_matches') }} 
    where team = 'Celtic'
    
),

final_cte as (

    select
        season,
        match,
        date,
        opponent,
        location,
        FTR,
        points,
        FTGF,
        FTGA,
        HTR,
        HTGF,
        HTGA,
        SF,
        SA,
        SoTF,
        SoTA,
        match_id
    
    from celtic_matches

)

select * 

from final_cte 
order by season, match