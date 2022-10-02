class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
    order_detail = OrderDetail.find(params[:id])
    order = Order.find(order_detail.order_id)
    status = params[:order_detail][:crafting_status]
    order_detail.update(crafting_status: status)
    case order_detail.crafting_status
      when "in_production"
				order_detail.order.update(order_status: "in_production")
			when "complete"
			if order_detail.order.order_details.all?{|order_detail| order_detail.crafting_status == "complete"}
				order_detail.order.update(order_status: "preparing_to_ship")
			end
		end
    redirect_to admin_order_path(order)
  end
end
