class ResortsController < ApplicationController
  
  #add create-esque verification to update
  #change Resort.find to Resort.find_by_id (returns nil if id not found)
  
  def index
    @resorts = Resort.order("id ASC")
  end
  
  def show
    @resort = Resort.find_by(id: params[:id])
    unless @resort
      redirect_to :back
    end
  end
  
  def new
    @resort = Resort.new()
  end
  
  def create
    @resort = Resort.new(resort_params)
    if @resort.valid?
      @resort.save
      redirect_to action: "show", id: @resort.id
    else
      render 'new'
    end
    
  end
  
  def edit
    @resort = Resort.find_by(id: params[:id])
  end
  
  def update
    @resort = Resort.find_by(id: params[:id])
    if @resort.update(resort_params)
      redirect_to action: "show", id: @resort.id
    else
      redirect_to action: "index"
    end
  end
  
  def destroy
    resort = Resort.find_by(id: params[:id])
    resort.delete
    redirect_to action: "index"
  end
  
  private
  
  def resort_params
    params.require(:resort).permit(:name, :latitude, :longitude, :state)
  end
  
end
