# frozen_string_literal: true

require_relative 'main'
require './modules/instance-counter'
require './modules/validation'
require './modules/accessors'

class Route
  attr_accessor :stations, :name

  ROUTE_PATTERN = /^[A-Z]{1}+[a-z]{1,}$/.freeze

  include InstanceCounter
  include Validation
  extend Accessors

  validate :@name, :format, ROUTE_PATTERN

  def initialize(first, terminal, name)
    @stations = [first, terminal]
    @name = name
    validate!
    register_instance
  end

  def add_station(station)
    @stations.insert(-2, station) unless @stations.include?(station)
  end

  def remove_station(station)
    @stations.delete(station) if @stations.include?(station) && station != @stations[0] && station != @stations[-1]
  end
end
