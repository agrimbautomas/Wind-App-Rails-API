class CreateWindAvgs < ActiveRecord::Migration[5.2]
  def change
    create_table :wind_avgs do |t|
			t.float :speed, null: false
			t.float :gust
			t.float :direction, null: false
			t.datetime :registered_date
    end
  end
end
