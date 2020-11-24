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
    # Атрибут мест/объема
    @volume = volume
    @free_volume = volume
    @used_volume = 0
    validate!
  end

  attr_reader :free_volume, :used_volume

  def validate!
    raise if @number !~ WAGON_PATTERN
  end
end
