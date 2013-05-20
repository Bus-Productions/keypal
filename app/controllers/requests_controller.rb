class RequestsController < ApplicationController
  # GET /requests
  # GET /requests.json
  def index
    @requests = Request.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @requests }
    end

  end

  def incoming
    
    number = params[:From]
    user = User.where(["number = ?", number]).first
    
    if user
      #handle the message

      @body = params[:Body]
      words = @body.split

      count = words.count
      
      first_word = words[0]
      first_word.downcase!
      first_word = first_word.gsub(" ", "")
      first_word = first_word.gsub(",", "")
      first_word = first_word.gsub(";", "")
      first_word = first_word.gsub(":", "")
      first_word = first_word.gsub(".", "")

      second_word = ""
      if count > 1
        second_word = words[1]
      end

      #if first_word == ''
      #  first_word = words[1].gsub(" ", "")
      #  --count
      #  second_word = words[2]
      #else
      #  second_word = words[1]
      #end
      #first_word.downcase!

      if first_word == 'info'

        @info_msg = Kptwilio.new(user.number, "+12052676367", "THIS IS THE INFO SCREEN")
        @info_msg.send

      elsif count == 1

        #retrieve pwd

      elsif count == 2
        
        #store pwd
        @key = Key.find_or_initialize_by_key_and_user_id(first_word, user.id)
        @key.update_attribute(:pass, second_word)

        @info_msg = Kptwilio.new(user.number, "+12052676367", "Created key with key: #{@key.key} and pass: #{@key.pass}")
        @info_msg.send

      else
      
        @info_msg = Kptwilio.new(user.number, "+12052676367", "We found your account. Your User ID: #{user_id}")
        @info_msg.send
      
      end

    else

      @info_msg = Kptwilio.new(number, "+12052676367", "We could not find your account. Visit http://keypal.herokuapp.com to Join.")
      @info_msg.send

    end

  end

  # GET /requests/1
  # GET /requests/1.json
  def show
    @request = Request.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @request }
    end
  end

  # GET /requests/new
  # GET /requests/new.json
  def new
    @request = Request.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @request }
    end
  end

  # GET /requests/1/edit
  def edit
    @request = Request.find(params[:id])
  end

  # POST /requests
  # POST /requests.json
  def create
    @request = Request.new(params[:request])

    respond_to do |format|
      if @request.save
        format.html { redirect_to @request, notice: 'Request was successfully created.' }
        format.json { render json: @request, status: :created, location: @request }
      else
        format.html { render action: "new" }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /requests/1
  # PUT /requests/1.json
  def update
    @request = Request.find(params[:id])

    respond_to do |format|
      if @request.update_attributes(params[:request])
        format.html { redirect_to @request, notice: 'Request was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requests/1
  # DELETE /requests/1.json
  def destroy
    @request = Request.find(params[:id])
    @request.destroy

    respond_to do |format|
      format.html { redirect_to requests_url }
      format.json { head :no_content }
    end
  end


  #FUNCTIONS

  private

  def send_sms to_number, from_number, body

    user_id = user.id
        message = @client.account.sms.messages.create(:body => body,
            :to => to_number,     # Replace with your phone number
            :from => from_number)   # Replace with your Twilio number
        puts message.sid

  end

end
