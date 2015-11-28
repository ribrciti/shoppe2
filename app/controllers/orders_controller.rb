class OrdersController < ApplicationController

	def index
		@orders = Order.all
	end

	def new
		@cart = current_cart
		if @cart.ordered_items.empty?
			redirect_to store_url, notice: "Your cart is empty"
			return		
		end
		@order = Order.new
		respond_to do |format|
			format.html # new.html.erb
			format.json { render json: @order }
		end
	end

	def create
		@order = Order.new(order_params)
		@order.add_ordered_items_from_cart(current_cart)
		
		respond_to do |format|
			if @order.save
				Cart.destroy(session[:cart_id])
				
				format.html {redirect_to store_url, notice:  'Thank you for your order.'}
				format.json {render json: @order, status: :created, location: @order}
			else
				@cart = current_cart
				format.html {render 'new', notice: "Your order was unabled to be saved!"}
				format.json {render json: @order.errors, status: :unprocessable_entity}
			end
		end
	end


	private

	def order_params
      params.require(:order).permit(:first_name, :last_name, :street_address, :city, :state, :zip, :email, :pay_type)
    end
end
