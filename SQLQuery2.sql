SELECT
	host_name,
	-- Count each listing host has published
	COUNT(id) as num_listings,
	case
		when count(id) = 1 then 'Single Listing'	
		when count(id) >= 40 then '40+ Listings'
		when count(id) >= 30 then '30+ Listings'
		when count(id) >= 20 then '20+ Listings'
		when count(id) >= 10 then '10+ Listings'
		else 'Multiple Listings'
	end as host_type
from 
	dbo.merged_data -- Merged data contains data from March 2024, and September 2024
group by
	host_name