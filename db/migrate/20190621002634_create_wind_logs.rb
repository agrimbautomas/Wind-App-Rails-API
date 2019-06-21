class CreateWindLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :wind_logs do |t|
			t.float :speed, null: false
			t.float :gust
			t.float :direction, null: false
			t.datetime :registered_date

			t.belongs_to :station

      t.timestamps
    end
  end
end
