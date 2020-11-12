# frozen_string_literal: true

require_relative 'company_name'
class Wagon
  include CompanyName
  include InstanceCounter
  attr_reader :type

  def initialize
    register_instance
  end
end

class PassengerWagon < Wagon
  include InstanceCounter
  def initialize
    super
    @type = 'Passenger'
  end
end

class CargoWagon < Wagon
  include InstanceCounter
  def initialize
    super
    @type = 'Cargo'
  end
end
