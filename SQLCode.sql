```ruby
require 'redcarpet'
markdown = Redcarpet.new("Hello World!")
puts markdown.to_html
```
/*
Cyclistic Case Study: Quarterly Data Exploration, 2022_Q1
Windows Functions, Aggregate Functions, Converting Data Types
*/

 -- Select columns from 2022_Q1 data to preview

SELECT  
        ride_id,
        started_at,
        ended_at,
        ride_length,
        day_of_week, 
        start_station_name,
        end_station_name,
        member_casual
FROM 
