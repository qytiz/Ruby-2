# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'validation'
class Station
  include InstanceCounter
  include Validation

  attr_reader :name, :trains_list

  @@all_stations = []

  validate :name, :presence

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

  def give_to_block(_block, &block)
    @trains_list.each(&block)
  end
end
