every 6.minutes do
  rake "scrape:wind_logs", :environment => 'production'
end


# Hourly tasks
every 60.minutes do
  rake "scrape:create_avgs", :environment => 'production'
  rake "scrape:windguru_logs", :environment => 'production'
end

