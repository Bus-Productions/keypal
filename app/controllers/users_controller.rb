class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  
  def index
    
  end


  def list_all
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    number = params[:number]
    @user = User.find_or_initialize_by_number("+1#{number}")

    if @user
      
      verify_code = rand(10**6)  
      session[:verify_code] = verify_code
      session[:saved_number] = @user.number
      session[:logged_in] = false

      @info_msg = Kptwilio.new(user.number, "+12052676367", "Welcome back. Enter this verification code so we know it's you:\n\n#{verify_code}")
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
    number = session[:saved_number]
    verify_code = session[:verify_code]
    submitted_code = params[:verify_code]

    if submitted_code == verify_code
      #verified
      session[:logged_in] = true
      @user = User.find_by_number(number)
      redirect_to @user
    end    

  end



  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
