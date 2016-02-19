class CarController < ApplicationController

  def new_car
    #check for user input for both the make and model year
    if !params.has_key?(:make) || !params.has_key?(:year)
      #if no user input, continue to render the page
      render "new_car"
    else
      #once the user adds input for both make and model year, create a new car object with those parameters
      car = Car.new(params[:make], params[:year])
      #store the new car object as a string in a session, to be used by other controllers
      session[:car] = car.to_yaml
      if params.has_key?(:description) && !params[:description].empty?
        #store the car description in a cookie, to be used by other controllers
        cookies[:description] = params[:description]
      end
      if params.has_key?(:color)
        #store the car color in a cookie, to be used by other controllers
        cookies[:color] = params[:color]
      end
      #redirect the user to the simulator page, which displays the simulated car
      redirect_to "/simulator/do"
    end
  end
end
