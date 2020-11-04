class Station
  attr_reader :name, :trains_list
  def initialize(name)
    @name = (name)
    @trains_list = []
  end

  def add_train(train)
    @trains_list << train
  end

  def remove_train(train)
    @trains_list.delete(train)
  end

  def show_trains_by_type(type)
    puts @trains_list.find_all{ |train| train.type == type}
  end

  def send_train(train)
    remove_train(train)
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
    @extra_stations.each{ |station| puts station.name }
    puts @last.name
  end
  def stations
    [@first, *@extra_stations, @last]
  end
end

class Train 
  attr_reader :number, :type, :route
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
 
  def route(route)
    @route = route
    @current_station = @route.stations[0]
    @current_station.add_train(self)
  end

  def move_forward
      @current_station.remove_train(self)
      @current_station = get_next_station
      @current_station.add_train(self)
  end

  def move_backward
      @current_station.remove_train(self)
      @current_station = get_ex_station
      @current_station.add_train(self)
  end

  def get_previous_station
  if @route.stations.index(@current_station) > 0
     @route.stations[@route.stations.index(@current_station) - 1]
  end
  end

  def get_current_station
     @current_station
  end

  def get_next_station
    if @route.stations.index(@current_station) < @route.stations.length - 1
       @route.stations[@route.stations.index(@current_station) + 1]
    end
  end
  
  def show_location
  puts get_previous_station
  puts "#{get_current_station} <--"
  puts get_next_station
  end

end

