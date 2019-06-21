ActiveAdmin.register WindLog do

	index do
		column :station
		column :speed
		column :gust
		column :direction
		column :registered_date
	end


end