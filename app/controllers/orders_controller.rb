class OrdersController < ApplicationController
	before_action :authenticate_user!

  def show
    @order = Order.find(params[:id])
  end

  def user_orders
  	@orders = current_user.orders
  end

  def user_sales
    @services = current_user.services
  end
end
