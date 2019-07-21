every 6.minutes do
  rake "scrape:wind_logs", :environment => 'production'
end

every 60.minutes do
  rake "scrape:hourly_tasks", :environment => 'production'
end

