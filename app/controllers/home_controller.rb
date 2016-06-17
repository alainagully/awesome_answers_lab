class HomeController < ApplicationController
#methods define in controllers are called 'actions'

  def index
  end

  def greet
    @name = params[:name]
    # we can use symbols or string to access vaues in the 'parmas'
  end


  def about
    #render text: "About Us!"

    #render :about, layout: "application"
    #this rells Rails to look for a file: /app/views/home/about.html.erb
    #it will render the file and send it as a response
    #layout: :applcation tells Rails  to use:
    #app/views/layouts/applcation.html.erb
    #render :about, layout: "application"
    #the line above is redundant becaue its the default Rails convention
  end
end
