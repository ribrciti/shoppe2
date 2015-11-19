class AddQuantityToOrderedItems < ActiveRecord::Migration
  def change
    add_column :ordered_items, :quantity, :integer, default: 1
  end
end
