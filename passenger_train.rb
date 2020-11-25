# frozen_string_literal: true

require_relative 'main'
require './modules/instance-counter'
require './modules/company-name'

class PassengerTrain < Train
  attr_reader :type

  def initialize(name)
    super
    @type = :passenger
  end
end
