# frozen_string_literal: true

require_relative 'main'
require './modules/company-name'

class Wagon
  WAGON_PATTERN = /^\d{2}$/.freeze

  attr_accessor :free_volume, :used_volume, :volume

  include CompanyName

  @instances = 0

  def initialize(number, volume)
    @number = number
    @volume = volume
    @free_volume = volume
    @used_volume = 0
    validate!
    # volume_validate!
  end

  # def volume_validate!
  #   case @type
  #   when :cargo
  #     raise if @volume.class != Float
  #   when :passenger
  #     raise if @volume.class != Integer
  #   end
  # end
  def validate!
    raise if @number !~ WAGON_PATTERN
  end

  def info
    puts "Тип вагона: #{type}, Поезд вагона #{train}, Номер вагона: #{number}"
  end

  protected

  attr_accessor :type, :train, :number
end
