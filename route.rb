# frozen_string_literal: true
require_relative 'main'
require './modules/instance-counter'

class Route
  attr_accessor :stations

  include InstanceCounter

  def initialize(first, terminal)
    @stations = [first, terminal]
    register_instance
  end

  def add_station(station)
    @stations.insert(-2, station) unless @stations.include?(station)
  end

  def remove_station(station)
    @stations.delete(station) if @stations.include?(station) && station != @stations[0] && station != @stations[-1]
  end
end
