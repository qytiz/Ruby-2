# frozen_string_literal: true

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

  def name
    "#{@first.name}-#{@last.name}"
  end

  def stations
    [@first, *@extra_stations, @last]
  end
end
