class ChargesController < ApplicationController

	def new
	end

	def create
	  # Amount in cents
	  @amount = 249

	  customer = Stripe::Customer.create(
	  	:email => 'test@test.com',
	    :plan => 'starter',
	    :card  => params[:stripeToken]
	  )

	  charge = Stripe::Charge.create(
	    :customer    => customer.id,
	    :amount      => @amount,
	    :description => 'KeyPal Subscriber',
	    :currency    => 'usd'
	  )

	  user_id = session[:user_id]
	  @user = User.find_by_id(user_id)
	  @user.update_attributes(:stripe_unique => customer.id, :active => 1, :level => 1)

	  @number = session[:saved_number]
	  @info_msg = Kptwilio.new(@number, "+12052676367", "Sweet! You've joined KeyPal. Text this number to store & retrieve keys.")
      @info_msg.send

		rescue Stripe::CardError => e
		  flash[:error] = e.message
		  redirect_to charges_path

	end

end
