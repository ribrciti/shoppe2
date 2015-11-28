class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :first_name
      t.string :last_name
      t.text :street_address
      t.text :city
      t.string :state
      t.integer :zip
      t.string :email
      t.string :pay_type

      t.timestamps null: false
    end
  end
end
