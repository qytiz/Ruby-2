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

  def show_trains
    @trains_list.each { |train| puts train.number.to_s }
  end

  def show_trains_by_type(type)
    puts @trains_list.find_all { |train| train.type == type }
  end
end
