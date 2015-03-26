class UsersController < ApplicationController
  
  def create
    @user = User.new(user_params)
    
  #   if params["password"] == params["password_confirmation"]
  #     if @user.save
  #       session[:user_id] = @user.id
  #       redirect_to "/select_resorts" and return
  #     else
  #       redirect_to :back and return
  #     end
  #   else
  #     redirect_to(:back, flash: {pwd_alert: "Password and password confirmation do not match."}) and return
  #   end
  # end
    
    if @user.save
      session[:user_id] = @user.id
      redirect_to "/select_resorts" and return
    else
      render '/misc/welcome' and return
    end
  end
  
  def index
    @users = User.order("id ASC")
  end
  
  def show
    @user = User.find_by(id: params[:id])
    unless @user
      redirect_to :back
    end
  end
  
  def new
    @user = User.new()
  end
  
  # def create
  #   @user = User.new(user_params)
  #   if @user.valid?
  #     @user.save
  #     redirect_to action: "show", id: @user.id
  #   else
  #     render 'new'
  #   end
  
  def edit
    @user = User.find_by(id: params[:id])
  end
  
  def update
    @user = User.find_by(id: params[:id])
    if @user.update(user_params)
      redirect_to action: "show", id: @user.id
    else
      redirect_to action: "index"
    end
  end
  
  def destroy
    user = User.find_by(id: params[:id])
    user.delete
    redirect_to action: "index"
  end
  
  private
  
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
  
end
