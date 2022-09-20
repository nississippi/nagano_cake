class Public::ItemsController < ApplicationController
  def index
    @items = Item.where(is_active: true).order(id: "DESC")
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end


end
