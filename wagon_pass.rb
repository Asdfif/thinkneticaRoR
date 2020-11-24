# frozen_string_literal: true

require_relative 'main'
require './modules/company-name'

class PassengerWagon < Wagon
  attr_reader :type

  def initialize(number, volume)
    super
    @type = :passenger
  end

  def take_volume(volume)
  	if wagon.free_volume >= volume
      wagon.free_volume -= volume
      wagon.used_volume += volume
    end
  end
end
