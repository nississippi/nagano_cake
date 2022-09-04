class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end


  def confirm
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    if params[:order][:select_address] == "0"
      @order.shipping_postal_code = current_customer.postal_code
      @order.shipping_address = current_customer.address
      @order.shipping_name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:select_address] == "1"
      #配送先を１件も登録していない場合に備えた条件分岐が必要
      #findメソッドで見つからない場合エラーが返ってくる
      if current_customer.addresses.exists?
        @address = Address.find(params[:order][:address_id])
        @order.shipping_postal_code = @address.postal_code
        @order.shipping_address = @address.address
        @order.shipping_name = @address.name
      end
    elsif params[:order][:select_address] == "2"
      @address_new = Address.new
      @order.shipping_postal_code = @address.postal_code
      @order.shipping_address = @address.address
      @order.shipping_name = @address.name
    end
    @cart_items = current_customer.cart_items.all
    @total = 0
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      @address_new = Address.new(address_params)
      @address_new.customer_id = current_customer.id
      @address_new.save
      @cart_items = current_customer.cart_items.all
      @cart_items.each do |cart|
        order_detail = OrderDetail.new
        order_detail.item_id = cart.item_id
        order_detail.order_id = @order.id
        order_detail.tax_included_price = cart.item.with_tax_price
        order_detail.amount = cart.amount
        order_detail.save
      end
      current_customer.cart_items.destroy_all
      redirect_to orders_complete_path
    else
      render :new
    end

  end

  def complete
  end

  def index
  end

  def show
  end

  private

  def order_params
    params.require(:order).permit(:shipping_name, :shipping_address, :shipping_postal_code,
    :billing_amount, :payment)
  end

  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end
end
