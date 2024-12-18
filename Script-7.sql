with fplusg as (
	select fabd.ad_date,
	       fabd.url_parameters,
	       fabd.spend,
	       fabd.impressions, 
	       fabd.reach, 
	       fabd.clicks,
	       fabd.leads,
	       fabd.value 
	from public.facebook_ads_basic_daily fabd 
	left join public.facebook_campaign fc 
		on fabd.campaign_id = fc.campaign_id 
	left join public.facebook_adset fa 
		on fabd.adset_id = fa.adset_id 
	union all 
	select gabd.ad_date,
               gabd.url_parameters,
               gabd.spend,
	       gabd.impressions, 
	       gabd.reach, 
	       gabd.clicks,
	       gabd.leads,
	       gabd.value 
	from public.google_ads_basic_daily gabd
),
total_fg as (
	select ad_date,
        case when lower(substring(url_parameters,'utm_campaign=([^\&]+)'))='nan' 
        then null else lower(substring(url_parameters,'utm_campaign=([^\&]+)')) 
        end as utm_campaign,
               coalesce (spend,0) as spend,
	       coalesce (impressions,0) as impressions, 
	       coalesce (reach,0) as reach, 
	       coalesce (clicks,0) as clicks,
	       coalesce (leads,0) as leads,
	       coalesce (value,0) as value
	from fplusg 
)
select ad_date,
       utm_campaign,
       sum(spend ) as total_spend,
       sum(impressions) as total_impressions,
       sum(reach)as total_reach,
       sum(clicks) as total_clicks,
       sum(value) as total_value,
       case when sum(impressions)>0 then sum(clicks :: numeric)/ sum(impressions :: numeric) else 0 end as CTR,
       case when sum(clicks)>0 then sum(spend :: numeric)/sum(clicks ::numeric ) else 0 end as CPC,
       case when sum(impressions)>0 then sum(spend :: numeric)/sum(impressions :: numeric)*1000 else 0 end as CPM,
       case when sum(spend)>0 then (sum(value::numeric)-sum(spend::numeric)/sum(spend::numeric)) else 0 end as ROMI
from total_fg
group by ad_date,
       utm_campaign; 
      

      
      
      
      
    
   
