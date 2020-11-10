# frozen_string_literal: true

class Wagon
  attr_reader :type

  def initialize
    @type = ''
  end
end

class PassengerWagon < Wagon
  def initialize
    @type = 'Passenger'
  end
end

class CargoWagon < Wagon
  def initialize
    @type = 'Cargo'
  end
end
