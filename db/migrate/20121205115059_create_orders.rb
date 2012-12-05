class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :uid
      t.string :customer
      t.integer :qty
      t.integer :ship_qty
      t.string :state

      t.timestamps
    end
  end
end
