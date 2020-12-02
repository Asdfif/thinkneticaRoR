# frozen_string_literal: true

require_relative 'main'
require './modules/company-name'
require './modules/validation'

class CargoWagon < Wagon
  include Validation

  attr_reader :type

  WAGON_PATTERN = /^\d{2}$/.freeze
  validate :@number, :format, WAGON_PATTERN
  def initialize(number, volume)
    super
    @type = :cargo
  end

  def take_volume(volume)
    if wagon.free_volume >= volume
      wagon.free_volume -= volume
      wagon.used_volume += volume
    end
  end
end
