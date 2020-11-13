# frozen_string_literal: true

require_relative 'main'
class Route
  attr_accessor :stations

  def initialize(first, terminal)
    @stations = [first, terminal]
  end

  def add_station(station)
    @stations.insert(-2, station) unless @stations.include?(station)
  end

  def remove_station(station)
    @stations.delete(station) if @stations.include?(station) && station != @stations[0] && station != @stations[-1]
  end
end
