# frozen_string_literal: true

require_relative 'main'
class Train
  attr_accessor :name, :current_speed
  attr_reader :wagons, :current_station, :type, :stations, :route

  def initialize(name)
    @name = name
    @type = type
    @wagons = {}
    @current_speed = 0
  end

  def faster(speed)
    @current_speed += speed
  end

  def slower(speed)
    @current_speed -= speed
    @current_speed = 0 if @current_speed <= 0
  end

  # done
  def hook_wagon(wagon)
    if wagon && @current_speed.zero? && wagon.type == @type && wagon.train.nil? && @wagons.include?(wagon) == false
      @wagons.merge!({ wagon.number => wagon })
      wagon.train = self
    end
  end

  # done
  def unhook_wagon(wagon)
    if wagon && @current_speed.zero?
      @wagons.delete(wagon.number)
      wagon.train = nil
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
end
