
with fb as ( 
select 
	fabd.ad_date, 
	fc.campaign_name ,
	fa.adset_name,
	sum(fabd.spend ) as spend ,
	sum(fabd.impressions ) as impressions ,
	sum(fabd.reach ) as reach ,
	sum(fabd.clicks )as clicks ,
	sum(fabd.leads) as leads ,
	sum(fabd.value ) as value 
from public.facebook_ads_basic_daily fabd 
left join public.facebook_campaign fc 
on fc.campaign_id = fabd.campaign_id 
left join  public.facebook_adset fa 
on fa.adset_id = fabd.adset_id
where fabd.ad_date is not null 
group by fabd.ad_date, 
	fc.campaign_name ,
	fa.adset_name
	) ,
	fplusg as (
select ad_date,
		'Facebook ads' as media_source ,
		campaign_name ,
		adset_name,
	sum(spend ) as spend ,
	sum(impressions ) as impressions ,
	sum(reach ) as reach ,
	sum(clicks )as clicks ,
	sum(leads) as leads ,
	sum(value ) as value 
from fb f 
group by ad_date ,
		media_source,
		campaign_name ,
		adset_name 
union all 
select gabd.ad_date,
		'Google ads' as media_source,
		gabd.campaign_name,
		gabd.adset_name,
		sum(gabd.spend ) as spend ,
	sum(gabd.impressions ) as impressions ,
	sum(gabd.reach ) as reach ,
	sum(gabd.clicks )as clicks ,
	sum(gabd.leads) as leads ,
	sum(gabd.value ) as value 
from public.google_ads_basic_daily gabd 
group by ad_date ,
	media_source,
	campaign_name ,
	adset_name
),
total as ( 
select ad_date,
	   media_source,
	   campaign_name,
	   adset_name,
	   sum(spend) as spend,
	   sum(impressions) as impressions,
	   sum(clicks) as clicks,
	   sum(value) as value
from fplusg
group by ad_date,
	   media_source,
	   campaign_name,
	   adset_name 
)
select media_source,
	   campaign_name,
	   adset_name ,
	   sum(spend) as spend,
	   sum(impressions) as impressions,
	   sum(clicks) as clicks,
	   sum(value) as value,
	   sum(value :: numeric)/sum(spend :: numeric) - 1 as romi  
from total t 
group by media_source,
	   campaign_name,
	   adset_name
having sum(spend) > 500000
order by romi desc 
limit 1 ;

	  





