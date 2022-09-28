class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def create
    @cart_item = current_customer.cart_items.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    @update_item = current_customer.cart_items.find_by(item_id: @cart_item.item_id)
    if @update_item.present?
      @update_item.amount += @cart_item.amount.to_i
      @update_item.save
    else
      @cart_item.save
    end
    redirect_to cart_items_path
    #カートに追加後、商品詳細画面を表示したままにするならredirect_to item_path(@cart_item.item_id)
    #saveやupdateは処理をしてtrueやfalseを返すメソッドなので、いきなりifの中に書いても処理できる
  end

  def index
    @cart_items = current_customer.cart_items.all
    @total = 0
  end

  def update
    cart_item = CartItem.find(params[:id])
    cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end

  private
  def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount)
  end
end
