class ChargesController < ApplicationController
	def new
	end

	def create
		
  customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => params[:total_price],
      :description => params[:description],
      :currency    => 'usd'
    )

    service = Service.find(params[:service_id])

    order = Order.create(
      user: current_user,
      service: service,
      service_id: params[:service_id],
      stripe_email: params[:stripeEmail],
      price: params[:price],
      total_price: params[:total_price],
      quantity: params[:quantity],
      description: charge.description,
      currency: charge.currency,
      stripe_customer_id: customer.id )

    redirect_to user_orders_path

	rescue Stripe::CardError => e
	  flash[:error] = e.message
	  redirect_to new_charge_path
	end

end
