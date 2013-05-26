class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  
  def index
    
    @user = User.new
    @reference_id = params[:ref]
    session[:reference_id] = @reference_id

  end

  # GET /users/1
  # GET /users/1.json
  def show

    @saved_number = session[:saved_number]
    @saved_encrypted_number = Digest::SHA1.hexdigest("#{@saved_number}sm1thsbeach_21_wls")

    @user = User.find(params[:id])

    @match = (@user.number == @saved_encrypted_number)
    @active = @user.active

    if ( @user.number == @saved_encrypted_number )
        #logged in
        session[:user_id] = @user.id

        respond_to do |format|
          format.html # show.html.erb
          format.json { render json: @user }
        end
    else
      redirect_to home_url
    end

    rescue ActiveRecord::RecordNotFound
      redirect_to(home_url, :notice => 'Record not found') and return

  end


  # POST /users
  # POST /users.json
  def create
    number = params[:user][:number]
    number = number.gsub(" ", "")
    number = number.gsub("(", "")
    number = number.gsub(")", "")
    number = number.gsub("+", "")
    number = number.gsub("[", "")
    number = number.gsub("]", "")
    number = number.gsub(".", "")
    number = number.gsub(",", "")
    number = number.gsub("-", "")
    number = number.gsub("_", "")
    number.strip!

    full_number = "+1#{number}"
    encrypted_number = Digest::SHA1.hexdigest("#{full_number}sm1thsbeach_21_wls")
    @user = User.find_or_initialize_by_number(encrypted_number)

    if @user.save
      
      verify_code = rand(10**6)  
      session[:verify_code] = verify_code
      session[:saved_number] = full_number
      session[:logged_in] = false

      @info_msg = Kptwilio.new(full_number, "+12052676367", "Well hello. Verify your number using this code:\n\n#{verify_code}")
      @info_msg.send

      redirect_to verify_url

    else 
      
      verify_code = rand(10**12)
      session[:verify_code] = verify_code
      session[:saved_number] = 500
      session[:logged_in] = false

      format.html { render action: "index" }
      format.json { render json: @request.errors, status: :unprocessable_entity }

    end

  end



  def verify
  end


  def login
    @number = session[:saved_number]
    encrypted_number = Digest::SHA1.hexdigest("#{@number}sm1thsbeach_21_wls")
    @verify_code = session[:verify_code]
    @submitted_code = params[:verify_code]

    if @submitted_code.to_i == @verify_code.to_i
      #verified
      session[:logged_in] = true
      @user = User.find_by_number(encrypted_number)
      session[:user_id] = @user.id

      #CHECK HERE FOR WHETHER THEY ARE NEW SUBSCRIBER OR NOT (STRIPE)
      if @user.stripe_unique && @user.active == 1
        #active subs
      else
        #non-active subs
        @info_msg = Kptwilio.new(@number, "+12052676367", "You're verified. Neat-o! Become a member to start storing your keys.")
        @info_msg.send
      end

      #@info_msg = Kptwilio.new(@number, "+12052676367", "You're verified. Neat-o! Text this number to store & retrieve keys.")
      #@info_msg.send

      #@info_msg = Kptwilio.new(@number, "+12052676367", "Store a key:\nkey password\n\nRetrieve a password:\nkey\n\nList all your keys:\nall\n\nVisit http://www.keypalapp.com/info for all commands.")
      #@info_msg.send

      redirect_to @user
    else
      redirect_to verify_path, notice: 'Your code did not match our verification code on file.'
    end

  end


end
