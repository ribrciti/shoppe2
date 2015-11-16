class ProductsController < ApplicationController

	before_action :find_product, only: [:show, :edit, :update, :destroy]

	def index
		@products = Product.all.order("created_at DESC")
	end

	def new
		@product = Product.new
		@product.id = Product.maximum(:id)+1
		
	end

	def create
		@product = Product.new(product_params)

		if @product.save
			redirect_to @product, notice: "Your Product was successfully saved!"
		else
			render 'new', notice: "Your article was unable to be saved!"
		end
	end

	def show
	end

	def edit		
	end

	def update
		if @product.update(product_params)
			redirect_to @product, notice: "Your udpdate was successful!"
		else
			render 'edit'
		end
	end

	def destroy
		@product.destroy
		redirect_to products_path
	end

	private

	def find_product
		@product = Product.find(params[:id])
	end

	def product_params
		params.require(:product).permit(:name, :sku, :description, :short_description,
		 :permalink, :weight, :price, :cost_price, :category_name)
	end

end
