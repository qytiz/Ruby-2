# frozen_string_literal: true

class Station
  attr_reader :name, :trains_list

  def initialize(name)
    @name = name
    @trains_list = []
<<<<<<< Updated upstream
=======
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
>>>>>>> Stashed changes
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

  private

  def validate!
    raise 'Название не может быть пустым' if name.length <= 0
  end
end
