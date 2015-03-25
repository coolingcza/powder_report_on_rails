class SessionsController < ApplicationController
 
  def new
  end
  
  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      if @user.resorts.empty?
        redirect_to "/select_resorts" and return
      else
        redirect_to "/display" and return
      end
    else
      # flash.now[:alert] = 'Username or password is invalid.'
      redirect_to(:back, flash: {alert: "Username or password is invalid."}) and return
    end
  end
  
  def log_out
    reset_session
    redirect_to "/powder_report" and return
  end  
  
end
