class Station
  attr_reader :name,:trains_list
  def initialize(name)
    @name=(name)
    @trains_list=[]
  end
  def add_train(train)
    @trains_list<<train
  end
  def show_trains
    @trains_list.each{ |train| puts train.number}
  end
  def show_trains_by_type(type)
    trainType=@trains_list.find_all{ |train| train.type == type}
    puts "Количество поездов #{type} равно #{trainType.length}"
    trainType.each{ |train| puts train}
  end
  def send_train(train)
    @trains_list.delete(train);
    
  end
end

class Route
  attr_reader :first,:optional_s,:last
  def initialize(first,last)
   @first=first;
   @last=last;
   @optional_s=[];
  end
  def add_station(station)
    @optional_s<<station;
  end
  def remove_station(station)
    @optional_s.delete(station)
  end
  def show_stations
    puts @first.name;
    @optional_s.each{|station|puts station.name};
    puts @last.name;
  end
end

class Train 
  attr_reader :number,:type,:route;
  def initialize(number,type,wagon_counter)
    @number=number;
    @type=type;
    @wagon_counter=wagon_counter;
    @speed=0;
    @station_number=0;
    @route=[]
  end
  def add_speed(speed)
    @speed+=speed;
  end
  def current_speed
    print "Текущая скорость =";
    puts @speed;
  end
  def drop_speed
    @speed=0;
  end
  def current_wagon
    print "Текущее число вагонов =";
    puts @wagon_counter;
  end
  def wagon(operation)
    if !(@speed > 0)
      if operation=='raise'
        @wagon_counter+=1;
      else
        @wagon_counter-=1;
      end
    end
  end
  def route(route)
  @route<<route.first;
  @route+=route.optional_s;
  @route<<route.last;
  @current_station=@route[0];
  end
  def move_forward
  @station_number+=1;  
  if @station_number<@route.length
    @current_station=@route[@station_number];
  else
    @station_number-=1;
  end
  end

  def move_backward
    @station_number-=1;  
    if @station_number>=0
      @current_station=@route[@station_number];
    else
      @station_number-=1;
    end
  end

  def show_route
    if @station_number== @route.length-1
      puts @route[@station_number-1].name;
      puts "#{@route[@station_number].name}  <--";
    else
    if @station_number == 0
      puts "#{@route[@station_number].name}  <--";
      puts @route[1].name;
    else
      puts @route[@station_number-1].name;
      puts "#{@route[@station_number].name}  <--";
      puts @route[@station_number+1].name;
    end
    end
  end
end

