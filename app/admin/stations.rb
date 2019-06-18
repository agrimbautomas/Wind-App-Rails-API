ActiveAdmin.register Station do
	permit_params :name

	#
	# Filters and Actions
	#

	index do
		selectable_column
		id_column
		column :name
		actions
	end

	filter :name
	filter :created_at

	form do |f|
		f.semantic_errors
		f.object.errors.keys

		inputs do
			input :name
		end

		actions

	end

	show do |station|

		attributes_table_for station do
			row :name
		end

	end

end