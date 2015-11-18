class StoreController < ApplicationController

  def index
  	@products = Product.all.order(:name).limit(4)
  end

end
