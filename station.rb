# frozen_string_literal: true
require_relative 'main'
require './modules/instance-counter'

class Station
  attr_accessor :trains, :name, :type

  include InstanceCounter

  @@all_stations = []

  def initialize(name)
    @name = name
    @trains = []
    @@all_stations << self
    register_instance
  end

  def show_type_trains(type)
    @trains.each do |train|
      train if train.type == type
    end
  end

  def send_train(train)
    @trains.delete(train)
  end

  def self.all
    @@all_stations
  end
end
