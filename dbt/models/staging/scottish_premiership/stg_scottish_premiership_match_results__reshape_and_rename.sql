{% set league = 'Scottish Premiership' %}


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
        clean_date as date,
        HomeTeam as team,
        AwayTeam as opponent,
        'Home' as location,
        
        case
            when FTR = 'H' then 'Win'
            when FTR = 'A' then 'Loss'
            else 'Draw'
        end as FTR,    
    
        FTHG as FTGF,
        FTAG as FTGA,

        case
            when HTR = 'H' then 'Winning'
            when HTR = 'A' then 'Losing'
            else 'Drawing'
        end as HTR,        
    
        HTHG as HTGF,
        HTAG as HTGA,
        
        HS as SF,
        away_shots as SA,
        
        HST as SoTF,
        AST as SoTA

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
        clean_date as date,
        AwayTeam as team,
        HomeTeam as opponent,
        'Away' as location,
        
        case
            when FTR = 'H' then 'Loss'
            when FTR = 'A' then 'Win'
            else 'Draw'
        end as FTR,
        
        FTAG as FTGF,
        FTHG as FTGA,
    
        case
            when HTR = 'H' then 'Losing'
            when HTR = 'A' then 'Winning'
            else 'Drawing'
        end as HTR,
        
        HTAG as HTGF,
        HTHG as HTGA,
        
        away_shots as SF,
        HS as SA,
            
        AST as SoTF,
        HST as SoTA
    
    from match_results
    where AwayTeam = '{{ team }}'
    
    {% if not loop.last %} union all {% endif %}
    {% endfor %}

),  

final_cte as (
    
    select 
        *,
        '{{ league }}' as league,
    
    from home_results
    
    union all
    
    select 
        *,
        '{{ league }}' as league,
    
    from away_results

)

select * from final_cte