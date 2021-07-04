with

celtic_matches as (

    select * 
    
    from {{ ref('celtic_matches') }}
    where season in (
        '2020-21',
        '2019-20',
        '2018-19',
        '2017-18',
        '2016-17',
        '2015-16',
        '2014-15',
        '2013-14'
    )
    
),

final_cte as (

    select
        season,
        max(match) as MP,
        sum(points) as points,
        avg(points) as PPG,
        
        avg(SF) as SF,
        avg(SA) as SA,
        avg(SoTF) as SoTF,
        avg(SoTA) as SoTA,
        avg(FTGF) as GF,
        avg(FTGA) as GA,

        100 * (sum(SF) / (sum(SF) + sum(SA))) as TSR,
        100 * (sum(SoTF) / (sum(SoTF) + sum(SoTA))) as SoTR,
        100 * (sum(FTGF) / (sum(FTGF) + sum(FTGA))) as GR,
                                  
        100 * (sum(SoTF) / sum(SF)) as SoTF_rate,
        100 * (1 - (sum(SoTA) / sum(SA))) as SoTA_rate,
        100 * ((sum(SoTF) / sum(SF)) + (1 - (sum(SoTA) / sum(SA)))) as SoT_rate_sum,
                                  
        100 * (sum(FTGF) / sum(SoTF)) as score_rate,
        100 * (1 - (sum(FTGA) / sum(SoTA))) as save_rate,
        100 * ((sum(FTGF) / sum(SoTF)) + (1 - (sum(FTGA) / sum(SoTA)))) as PDO
    
    from celtic_matches
    
    group by 1

)

select *

from final_cte
order by season