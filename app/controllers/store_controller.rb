class StoreController < ApplicationController

  def index
  	@products = Product.all.order(:name).limit(4)
  	@cart = current_cart
  end

end
