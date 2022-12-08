class DropTable < ActiveRecord::Migration[6.0]
  def change
    #drop_table :orders
    drop_table :placements
  end
end
