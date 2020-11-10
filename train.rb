# frozen_string_literal: true

class Train
  attr_reader :number, :route, :current_station, :wagons_array, :type

  def initialize(number)
    @number = number
    @speed = 0
    @wagons_array = []
    @type=''
  end

  def add_speed(speed)
    @speed += speed
  end

  def drop_speed
    @speed = 0
  end

  def add_route(route)
    @route = route
    @current_station = @route.stations[0]
    @current_station.add_train(self)
  end

  def move_forward
    @current_station.send_train(self)
    @current_station = next_station
    @current_station.add_train(self)
  end

  def move_backward
    @current_station.send_train(self)
    @current_station = previous_station
    @current_station.add_train(self)
  end

  def show_location
    puts previous_station
    puts "#{@current_station} <--"
    puts next_station
  end

  def remove_wagon
    @wagons_array.delete_at(@wagons_array.length - 1)
  end

  def add_wagon(wagon)
    @wagons_array << wagon if wagon.type == @type
  end

  protected

  def previous_station # Получать данные о следующей и предыдущей станциях требуется только поезду
    @route.stations[@route.stations.index(@current_station) - 1] if @route.stations.index(@current_station).positive?
  end

  def next_station
    if @route.stations.index(@current_station) < @route.stations.length - 1
      @route.stations[@route.stations.index(@current_station) + 1]
    end
  end
end

class PassengerTrain < Train
 
  def initialize(number)
    @number = number
    @speed = 0
    @wagons_array = []
    @type = 'Passenger'
  end


end

class CargoTrain < Train

  def initialize(number)
    @number = number
    @speed = 0
    @wagons_array = []
    @type = 'Cargo'
  end

end
