# frozen_string_literal: true

class Station
  attr_reader :name, :trains_list

  include InstanceCounter
  @@all_stations = []

  def initialize(name)
    @name = name
    @trains_list = []
    @@all_stations << self
    register_instance
  end

  def self.all
    @@all_stations
  end

  def add_train(train)
    @trains_list << train
  end

  def send_train(train)
    @trains_list.delete(train)
  end

  def show_trains_by_type(type)
    @trains_list.find_all { |train| train.type == type }
  end
end
