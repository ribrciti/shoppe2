class Product < ActiveRecord::Base

	has_many :ordered_items

	before_destroy :ensure_not_referenced_by_any_line_item

  validates_presence_of :name, :description
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :name, uniqueness: true, length: { minimum: 10, message: "Gotta be at least 10" }
  
  def self.latest
    Product.order(:updated_at).last
  end

  private

    #ensure that there are no line items referencing this product
    
    def ensure_not_referenced_by_any_ordered_item
      if ordered_items.empty?
        return true
      else
        errors.add(:base, 'Line Items present')
        return false
      end
    end
end