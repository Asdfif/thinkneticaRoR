# frozen_string_literal: true

require_relative 'main'
class PassengerWagon < Wagon
  attr_reader :type

  def initialize(number)
    super
    @type = :passenger
  end
end
