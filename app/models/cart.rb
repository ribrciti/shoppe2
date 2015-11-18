class Cart < ActiveRecord::Base

	has_many :ordered_items, dependent: :destroy

  def add_product(product_id)
    current_item = ordered_items.find_by(product_id: product_id)
    if current_item
      current_item.quantity += 1
    else
      current_item = ordered_items.build(product_id: product_id)
    end
    current_item
  end

  def total_price
    ordered_items.to_a.sum { |item| item.total_price }
  end
end
