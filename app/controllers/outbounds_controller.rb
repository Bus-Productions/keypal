class OutboundsController < ApplicationController
  # GET /outbounds
  # GET /outbounds.json
  def index
    @outbounds = Outbound.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @outbounds }
    end

    # Get your Account Sid and Auth Token from twilio.com/user/account 
    account_sid = 'ACe141f2c62c8497956a83d0ffa61eca27'
    auth_token = '7afb7431bb3d199bf07605c5c72271dc'
    @client = Twilio::REST::Client.new account_sid, auth_token
      
    message = @client.account.sms.messages.create(:body => "Hello, William",
        :to => "+12059360524",     # Replace with your phone number
        :from => "+12052676367")   # Replace with your Twilio number
    puts message.sid
    
  end

  # GET /outbounds/1
  # GET /outbounds/1.json
  def show
    @outbound = Outbound.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @outbound }
    end
  end

  # GET /outbounds/new
  # GET /outbounds/new.json
  def new
    @outbound = Outbound.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @outbound }
    end
  end

  # GET /outbounds/1/edit
  def edit
    @outbound = Outbound.find(params[:id])
  end

  # POST /outbounds
  # POST /outbounds.json
  def create
    @outbound = Outbound.new(params[:outbound])

    respond_to do |format|
      if @outbound.save
        format.html { redirect_to @outbound, notice: 'Outbound was successfully created.' }
        format.json { render json: @outbound, status: :created, location: @outbound }
      else
        format.html { render action: "new" }
        format.json { render json: @outbound.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /outbounds/1
  # PUT /outbounds/1.json
  def update
    @outbound = Outbound.find(params[:id])

    respond_to do |format|
      if @outbound.update_attributes(params[:outbound])
        format.html { redirect_to @outbound, notice: 'Outbound was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @outbound.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /outbounds/1
  # DELETE /outbounds/1.json
  def destroy
    @outbound = Outbound.find(params[:id])
    @outbound.destroy

    respond_to do |format|
      format.html { redirect_to outbounds_url }
      format.json { head :no_content }
    end
  end
end
