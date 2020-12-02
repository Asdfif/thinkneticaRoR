# frozen_string_literal: true

require_relative 'main'
require './modules/instance-counter'
require './modules/company-name'
require './modules/validation'
require './modules/accessors'

class CargoTrain < Train
  include Validation
  extend Accessors

  attr_reader :type

  TRAIN_PATTERN = /^([A-Z]{3}|\d{3})-{0,1}([A-Z]{2}|\d{2})$/i.freeze

  validate :@name, :format, TRAIN_PATTERN

  def initialize(name)
    super
    @type = :cargo
  end
end
