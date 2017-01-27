class UsersController < ApplicationController
    before_action :require_login, only: [:index, :show, :edit, :update, :destroy]
    # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  #GET /login
  def login
  end
  
  #GET /logout
  def logout
      session.delete(:user_id)
  end
  # authenticate with self.authenticate method in user_controller
  def authenticate
      @user = User.authenticate(params[:email], params[:password])
      if @user.nil?
          @errors = "Either email or password is incorrect"
          render :login
          else
          session[:user_id] = @user.id
          redirect_to user_path(@user)
      end
  end
  
  # GET /users/1
  # GET /users/1.json
  def show
  end

# GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  #add require_login method to redirect the user to the login page if the current _user is nil (lesson 17)
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password)
    end
    
    def require_login
        if current_user.nil?
            redirect_to :login
        end
    end
end