# frozen_string_literal: true

require_relative 'main'
class CargoTrain < Train
  attr_reader :type

  def initialize(name)
    super
    @type = :cargo
  end
end
