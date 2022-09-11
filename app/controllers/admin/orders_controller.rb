class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
    @total = 0
    @total_amount = 0
  end

  def update
    order = Order.find(params[:id])
    order_detail = OrderDetail.find(params[:id])
    if params[:order][:order_status].exists?
      status = params[:order][:order_status]
      order.update(order_status: status)
    elsif params[:order_detail][:crafting_status].exists?
      status = params[:order_detail][:crafting_status]
      order_detail.update(crafting_status: status)
    end

    redirect_to admin_order_path(order)


  end
end
