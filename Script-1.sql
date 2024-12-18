select 
	fabd.ad_date,
	fabd.spend ,
	fabd.clicks
from public.facebook_ads_basic_daily fabd ;

select 
	fabd.ad_date,
	fabd.spend ,
	fabd.clicks,
	fabd.spend / fabd.clicks 
from public.facebook_ads_basic_daily fabd 
where fabd.clicks >0;

select 
	fabd.ad_date,
	fabd.spend ,
	fabd.clicks,
	fabd.spend / fabd.clicks as S2C
from public.facebook_ads_basic_daily fabd 
where fabd.clicks >0
order by fabd.ad_date desc ;