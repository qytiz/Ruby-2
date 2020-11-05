# frozen_string_literal: true

class Station
  attr_reader :name, :trains_list

  def initialize(name)
    @name = name
    @trains_list = []
  end

  def add_train(train)
    @trains_list << train
  end

  def send_train(train)
    @trains_list.delete(train)
  end

  def show_trains_by_type(type)
    puts @trains_list.find_all { |train| train.type == type }
  end
end

class Route
  attr_reader :first, :extra_stations, :last

  def initialize(first, last)
    @first = first
    @last = last
    @extra_stations = []
  end

  def add_station(station)
    @extra_stations << station
  end

  def remove_station(station)
    @extra_stations.delete(station)
  end

  def show_stations
    puts @first.name
    @extra_stations.each { |station| puts station.name }
    puts @last.name
  end

  def stations
    [@first, *@extra_stations, @last]
  end
end

class Train
  attr_reader :number, :type, :route, :current_station
  
  def initialize(number, type, wagon_counter)
    @number = number
    @type = type
    @wagon_counter = wagon_counter
    @speed = 0
  end

  def add_speed(speed)
    @speed += speed
  end

  def drop_speed
    @speed = 0
  end

  def add_wagon
    @wagon_counter += 1
  end

  def remove_wagon
    @wagon_counter -= 1
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

  def previous_station
    @route.stations[@route.stations.index(@current_station) - 1] if @route.stations.index(@current_station).positive?
  end

  def next_station
    if @route.stations.index(@current_station) < @route.stations.length - 1
      @route.stations[@route.stations.index(@current_station) + 1]
    end
  end

  def show_location
    puts previous_station
    puts "#{@current_station} <--"
    puts next_station
  end
end
