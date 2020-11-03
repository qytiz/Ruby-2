class Station
  attr_reader :name,:trains_list
  def initialize(name)
    @name=(name)
    @trains_list=[]
  end

  def add_train(train)
    @trains_list<<train
  end

  def show_trains_by_type(type)
    puts @trains_list.find_all{ |train| train.type == type}
  end

  def send_train(train)
    if @trains_list.include? train
    @trains_list.delete(train)
    train.move_forward
    end
  end
end

class Route
  attr_reader :first,:extra_stations,:last
  def initialize(first,last)
   @first=first
   @last=last
   @extra_stations=[]
  end

  def add_station(station)
    @extra_stations<<station
  end

  def remove_station(station)
    @extra_stations.delete(station)
  end

  def show_stations
    puts @first.name
    @extra_stations.each{|station|puts station.name}
    puts @last.name
  end
end

class Train 
  attr_reader :number,:type,:route_serialized;
  def initialize(number,type,wagon_counter)
    @number=number
    @type=type
    @wagon_counter=wagon_counter
    @speed=0
    @station_number=0
    @route_serialized=[]
  end

  def add_speed(speed)
    @speed+=speed
  end

  def drop_speed
    @speed=0
  end

  def add_wagon
    @wagon_counter+=1
  end
  
  def remove_wagon
    @wagon_counter-=1
  end
 
  def route(route)
    @route_serialized<<route.first
    if route.extra_stations.is_a?(Array)
      @route_serialized+=route.extra_stations
    end
    @route_serialized<<route.last
    @current_station=@route_serialized[0]
    @current_station.add_train(self)
  end

  def move_forward
    if get_next_station.is_a?(Station)
      @current_station=get_next_station
      @station_number+=1
      @current_station.add_train(self)
    end
  end

  def move_backward
    if get_ex_station.is_a?(Station)
      @current_station=get_ex_station
      @station_number-=1
      @current_station.add_train(self)
    end
  end

  def get_ex_station
  if @station_number>0
    return @route_serialized[@station_number-1]
  end
  end

  def get_current_station
    return @route_serialized[@station_number]
  end

  def get_next_station
    if @station_number<@route_serialized.length-1
      return @route_serialized[@station_number+1]
    end
  end
  
  def show_route
  puts get_ex_station
  puts "#{get_current_station} <--"
  puts get_next_station
  end

end

