# frozen_string_literal: true

require_relative 'train'
require_relative 'wagon'
require_relative 'station'
require_relative 'route'
class Interface
  def initialize
    @stations = []
    @trains = []
    @routes = []
  end
  def menu
    puts 'Выбор действий:'
    puts '1.Создать станцию'
    puts '2.Создать поезд'
    puts '3.Создание/управление маршрутами'
    puts '4.Назначения маршрутов'
    puts '5.Добавить вагон к поезду'
    puts '6.Отцепить вагон  от поезда'
    puts '7.Переместить поезд по маршруту'
    puts '8.Просмотреть список станций и поездов на станции'
    puts '0.Выход'

    case gets.chomp.to_i
    when 1
      create_station
    when 2
      create_train
    when 3
      create_controll_route
    when 4
      add_route
    when 5
      add_wagon
    when 6
      remove_wagon
    when 7
      move_train
    when 8
      show_stations
    when 0
      abort
    end
    menu
  end

  def create_station
    puts 'Введите название станции'
    station_name = gets.chomp
    @stations << Station.new(station_name)
  end

  def create_train
    puts 'Укажите тип поезда'
    puts '1. Пассажирский'
    puts '2. Грузовой'
    train_type = gets.chomp.to_i
    puts 'Укажите номер поезда'
    train_number = gets.chomp.to_i
    case train_type
    when 1
      @trains << PassengerTrain.new(train_number)
    when 2
      @trains << CargoTrain.new(train_number)
    end
  end

  def create_controll_route
    puts '1.Создание маршрутов'
    puts '2.Управление маршрутами'
    case gets.chomp.to_i
    when 1
      puts 'Укажите отправную станцию из списка'
      @stations.each_with_index { |station, index| puts "#{index + 1}. #{station.name}" }
      route_begin = @stations[gets.chomp.to_i - 1]
      puts 'Укажите конечную станцию'
      @stations.each_with_index do |station, index|
        next if station == route_begin

        puts "#{index + 1}. #{station.name}"
      end
      @routes << Route.new(route_begin, @stations[gets.chomp.to_i - 1])
    when 2
      puts 'Укажите каким маршрутом необходимо управлять'
      @routes.each_with_index { |route, index| puts "#{index + 1}. #{route.name}" }
      route_index = gets.chomp.to_i - 1
      puts 'Укажите что сделать с маршрутом'
      puts '1.Добавить станцию'
      puts '2.Удалить станцию'
      case gets.chomp.to_i
      when 1
        puts 'Укажите какую станцию добавить'
        @stations.each_with_index do |station, index|
          next if [0].include?(index)

          puts "#{index + 1}. #{station.name}"
        end
        @routes[route_index].add_station(@stations[gets.chomp.to_i - 1])
      when 2
        puts 'Укажите какую станцию удалить'
        @routes[route_index].extra_stations.each_with_index { |station, index| puts "#{index + 1}. #{station.name}" }
        @routes[route_index].remove_station(@routes[route_index].extra_stations[gets.chomp.to_i - 1])
      end
    end
  end

  def add_route
    puts 'Укажите к какому поезду вы хотите добавить маршрут'
    @trains.each_with_index { |train, index| puts "#{index + 1}. #{train.number}" }
    train_index = gets.chomp.to_i - 1
    puts 'Укажите какой маршрут вы хотите добавить'
    @routes.each_with_index { |route, index| puts "#{index + 1}. #{route.name}" }
    @trains[train_index].add_route(@routes[gets.chomp.to_i - 1])
  end

  def add_wagon
    puts 'Укажите к какому поезду вы хотите добавить вагон'
    @trains.each_with_index { |train, index| puts "#{index + 1}. #{train.number}" }
    train_index = gets.chomp.to_i - 1
    if @trains[train_index].type == 'Cargo'
      @trains[train_index].add_wagon(CargoWagon.new)
    else
      @trains[train_index].add_wagon(PassengerWagon.new)
    end
  end

  def remove_wagon
    puts 'Укажите от какого поезда необходимо отцепить вагон'
    @trains.each_with_index { |train, index| puts "#{index + 1}. #{train.number}" }
    @trains[gets.chomp.to_i - 1].remove_wagon
  end

  def move_train
    puts 'Укажите куда вы хотите передвинуть  поезд'
    puts '1.Вперед'
    puts '2.Назад'
    direction = gets.chomp.to_i
    puts 'Укажите какой поезд вы хотите передвинуть'
    @trains.each_with_index { |train, index| puts "#{index + 1}. #{train.number}" }
    case direction
    when 1
      @trains[gets.chomp.to_i - 1].move_forward
    when 2
      @trains[gets.chomp.to_i - 1].move_backward
    end
  end

  def show_stations
    @stations.each do |station|
      puts station.name.to_s
      station.trains_list.each { |train| puts train.number.to_s }
    end
  end
end



ui = Interface.new
ui.menu()