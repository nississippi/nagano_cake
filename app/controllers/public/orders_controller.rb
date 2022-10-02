class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = current_customer.orders.new
    @address_new = current_customer.addresses.new
  end


  def confirm
    @order = current_customer.orders.new(order_params)
    @order.postage = 800
    @cart_items = current_customer.cart_items
    @select_address = params[:order][:select_address].to_i
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
      @order.shipping_postal_code =params[:order][:shipping_postal_code]
      @order.shipping_address = params[:order][:shipping_address]
      @order.shipping_name = params[:order][:shipping_name]
    end
    #情報に不足があれば入力ページに戻す
    #saveメソッドは
    if not  @order.shipping_postal_code.presence && @order.shipping_address.presence &&
      @order.shipping_name.presence
      redirect_to new_order_path
    end
    @total = 0
  end

  def create
    @order = current_customer.orders.new(order_params)
    @order.postage = 800
    if @order.save
      cart_items = current_customer.cart_items.all
        cart_items.each do |cart|
          order_detail = OrderDetail.new
          order_detail.item_id = cart.item_id
          order_detail.order_id = @order.id
          order_detail.tax_included_price = cart.item.tax_included_price
          order_detail.amount = cart.amount
          order_detail.save
        end

        if params[:order][:select_address] == "2"
          @address_new = current_customer.addresses.new
          #すでにorder_paramsを通過した@orderを使って値を取得するのでaddress_paramsはなくてもいい
          @address_new.postal_code = @order.shipping_postal_code
          @address_new.address = @order.shipping_address
          @address_new.name = @order.shipping_name
          @address_new.save
        end
      cart_items.destroy_all
      redirect_to orders_complete_path
    else
      render :new

    end

  end

  def complete
  end

  def index
    @orders = current_customer.orders.all.order(id: :DESC)
  end

  def show
    @order = Order.find(params[:id])
    unless @order.customer_id == current_customer.id
      redirect_to orders_path
    else
      @order_details = @order.order_details.all
      @total = 0
    end
  end

  private

  def order_params
    params.require(:order).permit(:shipping_name, :shipping_address, :shipping_postal_code,
    :billing_amount, :payment)
  end

end
