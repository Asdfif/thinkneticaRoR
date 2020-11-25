# frozen_string_literal: true

require_relative 'main'
require './modules/instance-counter'

class Route
  attr_accessor :stations
  attr_reader :name

  ROUTE_PATTERN = /^[A-Z]{1}+[a-z]{1,}$/.freeze

  include InstanceCounter

  def initialize(first, terminal, name)
    @stations = [first, terminal]
    @name = name
    validate!
    register_instance
  end

  def validate!
    raise if @name !~ ROUTE_PATTERN
  end

  def add_station(station)
    @stations.insert(-2, station) unless @stations.include?(station)
  end

  def remove_station(station)
    @stations.delete(station) if @stations.include?(station) && station != @stations[0] && station != @stations[-1]
  end
end
