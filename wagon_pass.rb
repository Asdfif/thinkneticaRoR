# frozen_string_literal: true

require_relative 'main'
require './modules/company-name'
require './modules/validation'

class PassengerWagon < Wagon
  include Validation
  WAGON_PATTERN = /^\d{2}$/.freeze

  attr_reader :type

  validate :@number, :format, WAGON_PATTERN

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
