# frozen_string_literal: true
require_relative 'main'
class PassengerTrain < Train
  attr_reader :type

  def initialize(name)
    super
    @type = :passenger
  end
end
