ActiveAdmin.register WindAvg do
	menu priority: 5

	actions :index

	config.sort_order = 'registered_date_desc'
	config.filters = false
	config.current_filters = false

	index do
		column :speed do |log|
			"#{log.speed} kts"
		end
		column :gust do |log|
			"#{log.gust} kts"
		end
		column :direction do |log|
			"#{log.direction}°"
		end
		column :source do |log|
			log.source
		end
		column :registered_date  do |log|
			log.registered_date
		end
	end

end