ActiveAdmin.register WindLog do

	actions :index

	index do
		column :station
		column :speed
		column :gust
		column :direction
		column :registered_date
	end


end