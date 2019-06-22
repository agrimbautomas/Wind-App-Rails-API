ActiveAdmin.register WindLog do
	menu priority: 5

	actions :index

	config.filters = false
	config.current_filters = false

	scope(:norden) do
		Station.find_by_slug('norden').wind_logs
	end

	scope(:colonia) do |log|
		Station.find_by_slug('colonia').wind_logs
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
		column :registered_date
	end


end