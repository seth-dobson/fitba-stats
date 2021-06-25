{% set seasons =  [
    
    '2000-01', 
    '2001-02',
    '2002-03',
    '2003-04',
    '2004-05',
    '2005-06',
    '2006-07',
    '2007-08',
    '2008-09',
    '2009-10',
    '2010-11',
    '2011-12',
    '2012-13',
    '2013-14',
    '2014-15',
    '2015-16',
    '2016-17',
    '2017-18',
    '2018-19',
    '2019-20',
    '2020-21'
    

] %}

{% for season in seasons %}
  
  select 
      *,
      '{{season}}' as season,
      {{ dbt_utils.surrogate_key(['Date', 'HomeTeam', 'AwayTeam']) }} as match_id
  
  from {{ source('scottish_premiership', season) }}

{% if not loop.last -%} union all {%- endif %}
{% endfor %}