with FB as (
	select fabd.ad_date,
	       fc.campaign_name,
	       fa.adset_name,
	       fabd.spend,
	       fabd.impressions,
	       fabd.reach,
	       fabd.clicks,
	       fabd.leads,
	       fabd.value 
	from public.facebook_ads_basic_daily fabd 
	left join public.facebook_campaign fc 
	on fc.campaign_id = fabd.campaign_id 
	left join public.facebook_adset fa 
	on fa.adset_id = fabd.adset_id 
),
fplusg as (
	select ad_date,
	       campaign_name,
	       adset_name,
	       spend, 
	       impressions,
	       reach,
	       clicks,
	       leads,
	       value,
	       'facebook' as media_source
	from FB
	union all
	select gabd.ad_date,
	       gabd.campaign_name, 
	       gabd.adset_name, 
	       gabd.spend, 
	       gabd.impressions,
	       gabd.reach, gabd.clicks,
	       gabd.leads,
	       gabd.value, 
	       'google' as media_source 
	from public.google_ads_basic_daily gabd )
select ad_date,
       media_source,
       campaign_name,
       adset_name,
       sum(spend) as spend,
       sum(impressions) as impressions,
       sum(reach) as reach,
       sum(clicks) as clicks,
       sum(leads) as leads,
       sum(value) as value
from fplusg
group by ad_date,
         media_source,
         campaign_name,
         adset_name
 ;
