class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :sku
      t.string :permalink
      t.text   :description
      t.text   :short_description
      t.decimal :weight, precision: 8, scale: 3, default: 0.0
      t.decimal :price, precision: 8, scale: 2, default: 0.0
      t.decimal :cost_price, precision: 8, scale: 2, default: 0.0
      t.boolean :featured
      t.string :category_name,  default: false

      t.timestamps null: false
    end
  end
end
