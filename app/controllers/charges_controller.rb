class ChargesController < ApplicationController

	def new
	end

	def create
	  # Amount in cents
	  @amount = 249

	  user_id = session[:user_id]
	  @user = User.find_by_id(user_id)

	  customer = nil
	  if @user.stripe_unique
	  	customer = Stripe::Customer.retrieve(@user.stripe_unique)
	  else
	  	customer = Stripe::Customer.create(
		  	:email => 'test@test.com',
		    :plan => 'starter',
		    :card  => params[:stripeToken]
	    )
	  end

	  #charge = Stripe::Charge.create(
	  #  :customer    => customer.id,
	  #  :amount      => @amount,
	  #  :description => 'KeyPal Subscriber',
	  #  :currency    => 'usd'
	  #)

	  @user.update_attributes(:stripe_unique => customer.id, :active => 1, :level => 1)

	  if session[:reference_id] && session[:reference_id] > 0
	  	@ref_user = User.find_by_id(session[:reference_id])
	  	cu = Stripe::Customer.retrieve(@ref_user.stripe_unique)
		cu.update_subscription(:coupon => "freemonth")
	  end

	  @number = session[:saved_number]
	  @info_msg = Kptwilio.new(@number, "+12052676367", "Sweet! You've joined KeyPal. Text this number to store & retrieve keys. Text 'info' for more info/help.")
      @info_msg.send

		rescue Stripe::CardError => e
		  flash[:error] = e.message
		  redirect_to @user, notice: 'The charge could not be completed. Please try again.'

	end

	
	def cancel
		
		user_id = session[:user_id]
	  	@user = User.find_by_id(user_id)

	  	cu = Stripe::Customer.retrieve(@user.stripe_unique)
		cu.cancel_subscription

		@user.update_attributes(:stripe_unique => cu.id, :active => 0, :level => 0)

	end

	def upgrade
		
		user_id = session[:user_id]
	  	@user = User.find_by_id(user_id)

	  	cu = Stripe::Customer.retrieve(@user.stripe_unique)
		cu.update_subscription(:plan => "unlimited", :prorate => true)

		@user.update_attributes(:stripe_unique => cu.id, :active => 1, :level => 2)

	end


end
