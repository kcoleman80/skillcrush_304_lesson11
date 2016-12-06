class PinsController < ApplicationController
    
  def index
    @pins = Pin.all
  end
  
  def show_by_name
      @pin = Pin.find_by_slug(params[:slug])
      render :show
  end
  
  def new
      @pin = Pin.new
  end
  
  def create
      @pin = Pin.create(params[:pin])
      if @pin.valid?
          @pin.save
          redirect_to pin_path(@pin)
      else
      @errors = @pin.errors
      render :new
      end
  end
  
  def edit
      @pin = Pin.find(params[:id])
      render :edit
  end
  
  private
  
  def pin_params
      params.require(:pin).permit(:title, :url, :slug, :text, :category_id)
  end
end