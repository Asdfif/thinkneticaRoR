# frozen_string_literal: true

require_relative 'main'
require './modules/company-name'

class Wagon
  WAGON_PATTERN = /^\d{2}$/.freeze

  attr_accessor :free_volume, :used_volume, :volume, :train, :type, :number

  include CompanyName

  @instances = 0

  def initialize(number, volume)
    @number = number
    #Атрибут мест/объема
    @volume = volume
    @free_volume = volume
    @used_volume = 0
    validate!
  end

  def free_volume
    @free_volume
  end

  def used_volume
    @used_volume
  end

  def validate!
    raise if @number !~ WAGON_PATTERN
  end
end
