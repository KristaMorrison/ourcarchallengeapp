class SimulatorController < ApplicationController
  def do
    @car_object = YAML.load(session[:car])
    @make = @car_object.make
    @year = @car_object.year
    @color = cookies[:color]
  end

  def lights
    #pull the car object out of the session
    @car_object = YAML.load(session[:car])
    #if the value of the radio button is "on", call the turnLightsOn method on the car object
    if params[:lights] == "On"
      @car_object.turnLightsOn
    elsif params[:lights] == "Off"
      #otherwise, call the turnLightsOff method on the car object
      @car_object.turnLightsOff
    end
    session[:car] = @car_object.to_yaml
    redirect_to "/simulator/do"
  end

  def accelerate
    #pull the car object out of the session
    @car_object = YAML.load(session[:car])
    #call the accelerate method on the car object
    @car_object.accelerate(10)
    session[:car] = @car_object.to_yaml
    redirect_to "/simulator/do"
  end

  def brake
    #pull the car object out of the session
    @car_object = YAML.load(session[:car])
    #call the brake method on the car object
    @car_object.brake(7)
    session[:car] = @car_object.to_yaml
    redirect_to "/simulator/do"
  end

  def parking_brake
    #pull the car object out of the session
    @car_object = YAML.load(session[:car])
    #if the value of the radio button is "on", call the turnBrakeOn method on the car object
    if params[:parking_brake] == "On"
      @car_object.turnBrakeOn
    elsif params[:parking_brake] == "Off"
      #otherwise, call the turnBrakeOff method on the car object
      @car_object.turnBrakeOff
    end
    session[:car] = @car_object.to_yaml
    redirect_to "/simulator/do"
  end
end
