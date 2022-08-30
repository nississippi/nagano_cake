class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end
  
  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    if @order.save
      redirect_to orders_confirm_path
    else
      render :new
    end
  end

  def confirm
  end

  def complete
  end

  def index
  end

  def show
  end
end
