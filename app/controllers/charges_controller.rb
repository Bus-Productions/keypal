class ChargesController < ApplicationController

	def new
	end

	def create
	  # Amount in cents
	  @amount = 249

	  customer = Stripe::Customer.create(
	    :plan => 'starter',
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

	user_id = session[:user_id]

	@user = User.find_by_id(user_id)

	@user.update_attribute(:stripe_unique, customer.id)

end
