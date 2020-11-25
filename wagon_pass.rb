# frozen_string_literal: true

require_relative 'main'
require './modules/company-name'

class PassengerWagon < Wagon
  attr_reader :type

  def initialize(number, volume)
    super
    @type = :passenger
  end

  def take_volume
    if wagon.free_volume >= 1
      wagon.free_volume -= 1
      wagon.used_volume += 1
    end
  end
end
