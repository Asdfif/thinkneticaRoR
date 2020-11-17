# frozen_string_literal: true

require_relative 'main'
require './modules/company-name'

class Wagon
  WAGON_PATTERN = /^\d{2}$/.freeze

  include CompanyName

  @instances = 0

  def initialize(number)
    @number = number
    validate!
  end

  def validate!
    raise if @number !~ WAGON_PATTERN
  end

  def info
    puts "Тип вагона: #{type}, Поезд вагона #{train}, Номер вагона: #{number}"
  end

  protected

  attr_accessor :type, :train, :number
end
