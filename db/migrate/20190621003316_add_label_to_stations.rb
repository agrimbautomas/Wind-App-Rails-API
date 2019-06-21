class AddLabelToStations < ActiveRecord::Migration[5.2]
  def change
    add_column :stations, :slug, :string, null: false
  end
end
