class AddOrderIdToOrderedItem < ActiveRecord::Migration
  def change
    add_column :ordered_items, :order_id, :string
  end
end
