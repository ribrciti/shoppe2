class StoreController < ApplicationController

  def index
  	@products = Product.all.order(:id).paginate(page: params[:page], per_page: 3)	
  	#@products = Product.all.order(:name).limit(4)
  	@cart = current_cart
  end

end
