{% macro get_home_stats(table, team) %}

    {% set query %}
    
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

        from {{ table }}
        where home_team = '{{ team }}'
    
    {% endset %}
    
    {% do run_query(query) %}
    
{% endmacro %}