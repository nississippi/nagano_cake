class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    cart_items = current_customer.cart_items.all
    if @order.save
      cart_items.each do |cart|
        order_detail = OrderDetail.new
        order_detail.item_id = cart.item_id
        order_detail.order_id = @order.id
        order_detail.tax_included_price = cart.item.with_tax_price
        order_detail.amount = cart.amount
        order_detail.save
      end
      redirect_to orders_confirm_path
      cart_items.destroy_all
    else
      render :new
    end
  end

  def confirm
    @order = Order.new(order_params)
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
    :billing_amount, :payment,)
  end
end
