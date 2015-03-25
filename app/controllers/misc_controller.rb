class MiscController < ApplicationController
  
  require_dependency 'wx_data'
  require_dependency 'map_string'
  require_dependency 'chart_data'
  
  def log_in
    @user = User.new
    # if params["invalid_password"]
    #   @message = "Invalid Password, please try again:"
    # elsif params["invalid_username"]
    #   @message = "Invalid username or password, please try again:"
    # end
    render '/misc/welcome'
  end
  
  
  def check_sign_in
  
    if User.exists?({username: params["username"]})
      user = User.find_by_username params["username"]
      #check password:
      if BCrypt::Password.new(user.password) == params["password"]
        session[:user_id] = user.id
      else
        redirect_to "/misc/welcome?invalid_password=true"
      end
    else
      user = User.new({username: params["username"], password: params["password"]})
      if user.valid?
        user.password = BCrypt::Password.create(user.password)
        user.save
        session[:user_id] = user.id
      else
        #add something to pass error message?
        redirect_to "/misc/welcome?invalid_username=true"
      end
    end
  
    if user.resorts.empty?
      redirect_to "/select_resorts"
    else
      redirect_to "/display"
    end
  end
  
  
  def select_resorts
    @state_list = Resort.get_states.map { |a| [a.state, a.state] }
    @state = session[:state]
  
    if params["surfeit"] 
      @surfeit_text = "Too many resorts selected.  Please select six or fewer."
    end
  
    if @state
      @resort_list = Resort.where("state = ?", @state)
      @resort_list = @resort_list.sort_by { |r| r.name }
    end
  
    # erb :"user_routes/select_resorts", :layout => :boilerplate
  end
  
  
  def set_state
    session[:state] = params["state"]
    redirect_to "/select_resorts"
  end
  
  
  def change_resorts
    selected_resorts = params.select{|k,v| v == "r_id"}.keys
    # check params for number of resorts
    if selected_resorts.length > 6
      redirect_to "/select_resorts?surfeit=yes"
    elsif selected_resorts.length == 0
      redirect_to "/select_resorts"
    else
      # delete existing user resorts
      user = User.find(session[:user_id])
      user.resorts.clear
      # add new user resorts
      selected_resorts.each do |r|
        user.resorts << Resort.find(r)
      end
      redirect_to "/display"
    end
  end
  
  
  def display
    
    puts "I am in display method"
    
    @user = User.find(session[:user_id])
    puts @user
    @user_resorts = @user.resorts
    puts @user_resorts
    @data = WxData.new()
    puts "after @data assignment"
    
    @user_resorts.each do |r|
   
      forecast = ForecastIO.forecast(r.latitude, r.longitude, options = {params: {exclude: 'currently,minutely,flags,alerts'}})
      puts "after forecast call"
      @data.build_marker_strings(forecast["daily"]["data"],r)
      @data.build_chart_series(forecast["hourly"]["data"],r)
    
    end
  
    @data.generate_map_urls
  
  end
  
  
  
end
