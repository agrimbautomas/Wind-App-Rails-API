class AddSourceToAvgs < ActiveRecord::Migration[5.2]
  def change
    add_column :wind_avgs, :source, :string, required: false
  end
end
