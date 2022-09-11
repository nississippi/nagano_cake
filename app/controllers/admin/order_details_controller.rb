class Admin::OrderDetailsController < ApplicationController
  def update
    order_detail = OrderDetail.find(params[:id])
    order = Order.find(order_detail.order_id)
    status = params[:order_detail][:crafting_status]
    order_detail.update(crafting_status: status)
    redirect_to admin_order_path(order)
  end
end
