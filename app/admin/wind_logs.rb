ActiveAdmin.register WindLog do
	menu priority: 5

	actions :index

	index do
		column :station
		column :speed
		column :gust
		column :direction do |log|
			"#{log.direction}°"
		end
		column :registered_date
	end


end