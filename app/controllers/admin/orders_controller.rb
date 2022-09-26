class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
    @total = 0
    @total_amount = 0
  end

  def update
    order = Order.find(params[:id])
    status = params[:order][:order_status]
    order.update(order_status: status)
    redirect_to admin_order_path(order)
  end
end
