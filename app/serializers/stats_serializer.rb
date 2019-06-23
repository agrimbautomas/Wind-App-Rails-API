class StatsSerializer < ActiveModel::Serializer

	attributes :speed, :gust, :direction, :registered_date

	def registered_date
		object.registered_date.strftime("%H:%M - %d/%m")
	end

end