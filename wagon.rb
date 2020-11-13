# frozen_string_literal: true

require_relative 'main'
class Wagon
  attr_accessor :type, :train, :number

  def initialize(number)
    @number = number
  end

  def info
    puts "Тип вагона: #{type}, Поезд вагона #{train}, Номер вагона: #{number}"
  end
end
