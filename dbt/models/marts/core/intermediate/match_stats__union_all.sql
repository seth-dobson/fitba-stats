{{ config(materialized = 'ephemeral') }}

select * from {{ ref('stg_scottish_premiership_match_results__reshape_and_rename') }}
   

