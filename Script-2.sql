select 
	ad_date ,
	campaign_id,
	sum(spend) as spend ,
	sum(impressions) as impressions ,
	sum(clicks) as clicks,
	sum(value) as value,
	sum(spend :: numeric)/sum(clicks) as cpc,
	sum(spend :: numeric)/sum(impressions)*1000 as cpm,
	sum(clicks :: numeric)/sum(impressions) as ctr,
	(sum(value :: numeric)- sum(spend :: numeric))/ sum(spend) as romi
from public.facebook_ads_basic_daily fabd 
where clicks > 0
group by fabd.ad_date ,
		fabd.campaign_id 
 ;