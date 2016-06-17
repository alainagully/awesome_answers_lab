class TempController < ApplicationController
  def index

  end

  def create
    @temp_c = params[:temp_c].to_f
    @temp_f = @temp_c * 1.8 + 32
    render :index
    
  end


end
