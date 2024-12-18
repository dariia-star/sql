with cte_table  as (
    select fabd.ad_date, fabd.spend, fabd.impressions, fabd.reach, 
    fabd.clicks, fabd.leads, fabd.value, 'facebook' as media_source 
    from public.facebook_ads_basic_daily fabd
    union all
    select gabd.ad_date, gabd.spend, gabd.impressions, gabd.reach,
    gabd.clicks, gabd.leads, gabd.value, 'google' as media_source 
    from public.google_ads_basic_daily gabd
  )
select ad_date, 
       media_source,
       sum(spend) as spend,
       sum(impressions) as impressions,
       sum(clicks) as clicks,
       sum(value) as value 
from cte_table
group by ad_date, media_source;








