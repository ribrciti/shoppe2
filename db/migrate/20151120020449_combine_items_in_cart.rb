class CombineItemsInCart < ActiveRecord::Migration
  def up
		# replace multiple items for a single product in a cart with a single item
		Cart.all.each do |cart|
			# count the number of each product in the cart
			sums = cart.ordered_items.group(:product_id).sum(:quantity)
			
			sums.each do |product_id, quantity|
				if quantity > 1					
					# remove individual items
					cart.ordered_items.where(product_id: product_id).delete_all
					# replace with a single item
					cart.ordered_items.create(product_id: product_id, quantity: quantity)
				end
			end
		end
	end

	def down
		# split items with quantity>1 into multiple items
		OrderedItem.where("quantity>1").each do |ordered_item|
			# add individual items
			ordered_item.quantity.times do
				OrderedItem.create cart_id: ordered_item.cart_id,
				product_id: ordered_item.product_id, quantity: 1
			end
			# remove original item
			ordered_item.destroy
		end
	end
end