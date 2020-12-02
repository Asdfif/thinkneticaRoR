# frozen_string_literal: true

require_relative 'main'
require './modules/company-name'
require './modules/validation'
require './modules/accessors'

class Wagon
  WAGON_PATTERN = /^\d{2}$/.freeze
  VOLUME_PATTERN = /\d.{0,1}\d/.freeze
  attr_accessor :free_volume, :used_volume, :volume, :train, :type, :number
  attr_reader :free_volume, :used_volume

  include CompanyName
  include Validation
  extend Accessors

  @instances = 0
  validate :@number, :format, WAGON_PATTERN

  def initialize(number, volume)
    @number = number
    validate!
    @volume = volume
    @free_volume = volume
    @used_volume = 0
  end
end
