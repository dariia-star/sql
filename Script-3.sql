select  campaign_id,
	sum(spend) as spend, 
	(sum(value :: numeric)- sum(spend :: numeric))/ sum(spend) as romi
from public.facebook_ads_basic_daily fabd 
group by fabd.campaign_id 
having sum(spend)> 500000
order by romi desc 
limit 1;
