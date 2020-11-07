# frozen_string_literal: true

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

class Train
  attr_accessor :name, :type, :stations, :route, :current_speed
  attr_reader :vagons, :current_station

  def initialize(name, type, vagons = 0)
    @name = name
    @type = type
    @vagons = vagons
    @current_speed = 0
  end

  def faster(speed)
    @current_speed += speed
  end

  def slower(speed)
    @current_speed -= speed
    @current_speed = 0 if @current_speed <= 0
  end

  def add_vagon
    @vagons += 1 if @current_speed.zero?
  end

  def del_vagon
    @vagons -= 1 if @current_speed.zero? && @vagons >= 1
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
