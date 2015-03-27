class UsersController < ApplicationController
  
  respond_to :html, :js
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      session[:user_id] = @user.id
      redirect_to "/select_resorts" and return
      
    else
      #render '/misc/welcome' and return (second form submission goes to users index)
      raise "Invalid User Info"
    end
    
  rescue
    #render '/misc/welcome' (same result: adds /users to url)
    render template: "misc/welcome"
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
