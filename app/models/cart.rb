class Cart < ActiveRecord::Base

	has_many :ordered_items, dependent: :destroy

  

  def total_price
    ordered_items.to_a.sum { |item| item.total_price }
  end
end
