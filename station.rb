# frozen_string_literal: true

require_relative 'main'
require './modules/instance-counter'

class Station
  attr_accessor :trains, :name, :type

  STATION_PATTERN = /^[A-Z]{1}+[a-z]{1,}$/.freeze

  include InstanceCounter

  @@all_stations = []

  def initialize(name)
    @name = name
    validate!
    @trains = []
    @@all_stations << self
    register_instance
  end

  def operation_with_trains(&block)
    @trains.each(&block)
  end

  def validate!
    raise if @name !~ STATION_PATTERN
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
