# frozen_string_literal: true

require_relative 'instance_counter'
class Station
  attr_reader :name, :trains_list

  include InstanceCounter
  @@all_stations = []

  def initialize(name)
    @name = name
    @trains_list = []
    @@all_stations << self
    register_instance

    validate!
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
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

  def give_to_block(block)
    @trains_list.each{ |train| yield(train) }
  end

  private

  def validate!
    raise 'Название не может быть пустым' if name.length <= 0
  end
end
