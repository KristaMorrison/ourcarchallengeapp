class Car

  def initialize(make, modelYear)
    @make = make
    @year = modelYear
    @speed = 0
    @lightsOn = false
    @parkingBrakeOn = false
  end

  #turnLightsOn sets the lightsOn instance variable to true
  def turnLightsOn
    @lightsOn = true
  end

  #turnLightsOff sets the lightsOn instance variable to false
  def turnLightsOff
    @lightsOn = false
  end

  #lightsOn? returns the value of the lightsOn instance variable
  def lightsOn?
    @lightsOn
  end

  def make
    @make
  end

  def year
    @year
  end
  #speed returns the speed
  def speed
    @speed
  end
  #accelerate takes in a rate of acceleration, and increases the speed of the instance by that rate
  def accelerate (rateOfAcceleration)
    if !@parkingBrakeOn
      @speed = @speed + rateOfAcceleration
    end
  end

  #brake takes in a rate of braking, and decreases the speed of the instance by that rate
  def brake (rateOfBraking)
    @speed = @speed - rateOfBraking
    #If the rate of braking takes the speed below zero, set the speed to zero
    if (@speed < 0)
      @speed = 0
    end
  end

  def brakeOn?
    @parkingBrakeOn
  end

  #turnBrakeOn sets the parkingBrakeOn instance variable to true
  def turnBrakeOn
    if @speed == 0
      @parkingBrakeOn = true
    end
  end

  #turnBrakeOff sets the parkingBrakeOn instance variable to false
  def turnBrakeOff
    @parkingBrakeOn = false
  end
end
