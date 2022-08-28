class Public::CartItemsController < ApplicationController
  def create
    @cart_item =CartItem.new
    @cart_item.save
  end

  def index
    @cart_items = CartItem.all
  end

  def update
    cart_item = CartItem.find(params[:id])
    cart_item.update(cart_item_params)
  end


  private
  def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount)
  end
end
