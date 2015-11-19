class OrderedItemsController < ApplicationController

  #before_action :set_cart, only: [:create, :update, :destroy]
  before_action :set_ordered_item, only: [:show, :edit, :update, :destroy]

 
  def index
    @ordered_items = OrderedItem.all
  end

  def show
  end

  
  def new
    @ordered_item = OrderedItem.new
  end

  
  def edit
  end
 
  def create
    @cart = current_cart
    product = Product.find(params[:product_id])
    @product = product
    @ordered_item = @cart.ordered_items.build(product: product)

    respond_to do |format|
      if @ordered_item.save
        format.html { redirect_to @ordered_item.cart, notice: 'Line item was successfully created' }
        format.json { render json: @ordered_item, status: :created, location: @ordered_item } 
      else
        format.html { render action: "new" }
        format.json { render json: @ordered_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @ordered_item.update(ordered_item_params)
        format.html { redirect_to @ordered_item, notice: 'Line item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @ordered_item.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @ordered_item.destroy
    render json: { order_total: "$%.2f" % @cart.total_price }
  end

  private
    
    def set_ordered_item
      @ordered_item = @cart.ordered_items.find_by(id: params[:item_id])
    end

    def ordered_item_params
      params.require(:ordered_item).permit(:product_id)
    end
end
