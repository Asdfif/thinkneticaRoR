# frozen_string_literal: true
require_relative 'main'
require './modules/company-name'

class Wagon
  attr_accessor :type, :train, :number

  include CompanyName

  @instances = 0

  def initialize(number)
    @number = number
  end

  def info
    puts "Тип вагона: #{type}, Поезд вагона #{train}, Номер вагона: #{number}"
  end
end
