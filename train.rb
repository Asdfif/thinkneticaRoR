# frozen_string_literal: true
require_relative 'main'
require './modules/instance-counter'
require './modules/company-name'

class Train

  attr_accessor :name, :current_speed, :trains
  attr_reader :wagons, :current_station, :type, :stations, :route

  include InstanceCounter
  include CompanyName

  @@trains = {}

  def initialize(name)
    @name = name
    @type = type
    @wagons = []
    @current_speed = 0
    @@trains.merge!({ name => self })
    register_instance
  end

  def faster(speed)
    @current_speed += speed
  end

  def slower(speed)
    @current_speed -= speed
    @current_speed = 0 if @current_speed <= 0
  end

  def hook_wagon(wagon)
    if wagon && @current_speed.zero? && wagon.type == @type && wagon.train.nil? && @wagons.include?(wagon) == false
      @wagons << wagon
      wagon.train = self
    end
  end

  def unhook_wagon
    if @current_speed.zero? && @wagons != []
      wagon = @wagons.last
      wagon.train = nil
      @wagons.delete_at(-1)
    end
  end

  def set_route(route)
    @route = route
    @current_station = route.stations[0]
    @current_station.trains << self
  end

  def next_station
    i = @route.stations.index(@current_station)
    return unless i < (@route.stations.size - 1)

    @route.stations[i + 1]
  end

  def previous_station
    i = @route.stations.index(@current_station)
    return unless i.positive?

    @route.stations[i - 1]
  end

  def forward
    return unless next_station

    next_station.trains << self
    @current_station = next_station
    previous_station.trains.delete(self)
    @current_station
  end

  def back
    return unless previous_station

    previous_station.trains << self
    @current_station = previous_station
    next_station.trains.delete(self)
    @current_station
  end

  def self.find(name)
    if @@trains.key?(name)
      @@trains[name]
    else
      false
    end
  end
end
