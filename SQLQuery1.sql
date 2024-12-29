SELECT
    host_name,
	-- Count each listing host has published
    CASE
        WHEN num_listings = 1 THEN 'Single Listing'    
        WHEN num_listings >= 40 THEN '40+ Listings'
        WHEN num_listings >= 30 THEN '30+ Listings'
        WHEN num_listings >= 20 THEN '20+ Listings'
        WHEN num_listings >= 10 THEN '10+ Listings'
        ELSE 'Multiple Listings'
    END AS host_type,
    AVG(price) AS avg_price,
    AVG(number_of_reviews) AS avg_reviews,
    AVG(availability_365) AS avg_availability,
    AVG(minimum_nights) AS avg_minimum_nights,
    year -- Include year (month) to sort data
FROM
    (
        SELECT
            host_name,
            COUNT(id) AS num_listings, 
            price,
            number_of_reviews,
            availability_365,
            minimum_nights,
            year
        FROM dbo.merged_data
        WHERE price IS NOT NULL AND price > 0 -- Filter out nulls
        GROUP BY host_name, price, number_of_reviews, availability_365, minimum_nights, year
    ) AS host_listing_counts
GROUP BY
    host_name, num_listings, year;  -- Group by host_name, num_listings, and year
