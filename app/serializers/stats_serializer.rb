class StatsSerializer < ActiveModel::Serializer

	attributes :id, :speed, :gust, :direction, :registered_date

	def registered_date
		object.registered_date.strftime("%H:%M - %d/%m")
	end

end