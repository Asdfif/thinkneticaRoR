# frozen_string_literal: true

require_relative 'main'
class CargoWagon < Wagon
  attr_reader :type

  def initialize(number)
    super
    @type = :cargo
  end
end
