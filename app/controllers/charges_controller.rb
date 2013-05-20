class ChargesController < ApplicationController

	def new
	end

	def create
	  # Amount in cents
	  @amount = 399

	  customer = Stripe::Customer.create(
	    :email => 'example@stripe.com',
	    :plan => 'keypal_2',
	    :card  => params[:stripeToken]
	  )

	  charge = Stripe::Charge.create(
	    :customer    => customer.id,
	    :amount      => @amount,
	    :description => 'KeyPal Subscriber',
	    :currency    => 'usd'
	  )

	rescue Stripe::CardError => e
	  flash[:error] = e.message
	  redirect_to charges_path
	end

end
