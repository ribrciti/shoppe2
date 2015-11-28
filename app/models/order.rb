class Order < ActiveRecord::Base

	has_many :ordered_items, dependent: :destroy
	
	PAYMENT_TYPES = [ "Check", "Credit card", "Purchase order" ]

	validates :first_name, :last_name, :street_address, :city, :state,
					  :zip, :email, :pay_type, presence: true
	validates :pay_type, inclusion: PAYMENT_TYPES

	def add_ordered_items_from_cart(cart)
		cart.ordered_items.each do |item|
			item.cart_id = nil
		end
		cart.ordered_items
	end
end

