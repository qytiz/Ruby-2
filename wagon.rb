# frozen_string_literal: true

require_relative 'company_name'
class Wagon
  include CompanyName
  include InstanceCounter
  attr_reader :type,:taken_space, :number
  def initialize(space)
    @all_space=space;
    @taken_space=0;
    @number=rand(10000...99999)
  end

  def left_space
  @all_space-@taken_space;
  end
end

class PassengerWagon < Wagon
  def initialize(space)
    super
    @type = 'Passenger'
  end

  def take_space
    @taken_space+=1;
  end

end

class CargoWagon < Wagon
  include InstanceCounter
  def initialize(space)
    super
    @type = 'Cargo'
  end
  
  def take_space(space)
  @taken_space+=space;
  end
end
