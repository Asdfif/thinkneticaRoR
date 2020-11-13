# frozen_string_literal: true

require_relative 'main'
class Station
  attr_accessor :trains, :name, :type

  def initialize(name)
    @name = name
    @trains = []
  end

  def show_type_trains(type)
    @trains.each do |train|
      train if train.type == type
    end
  end

  def send_train(train)
    @trains.delete(train)
  end
end
