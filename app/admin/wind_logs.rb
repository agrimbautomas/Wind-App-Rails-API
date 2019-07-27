ActiveAdmin.register WindLog do
	menu priority: 10

	actions :index

	config.sort_order = 'registered_date_desc'
	config.filters = false
	config.current_filters = false

	scope(:norden) do
		Station.find_by_slug('norden').wind_logs.order('registered_date DESC')
	end

	scope(:colonia) do
		Station.find_by_slug('colonia').wind_logs.order('registered_date DESC')
	end

	scope(:windguru) do
		Station.find_by_slug('windguru').wind_logs.order('registered_date DESC')
	end

	index do
		column :station
		column :speed do |log|
			"#{log.speed} kts"
		end
		column :gust do |log|
			"#{log.gust} kts"
		end
		column :direction do |log|
			"#{log.direction}°"
		end
		column :registered_date  do |log|
			log.registered_date
		end
	end

end