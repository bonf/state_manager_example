class AddFields < ActiveRecord::Migration
  def up
    add_column :orders, :set_id, :integer
    add_column :orders, :store_worker, :string
  end

  def down
    remove_column :orders, :set_id
    remove_column :orders, :store_worker
  end
end
