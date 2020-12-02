# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validations_array
      @validations
    end

    def validate(value, validation_type, *option)
      @validations ||= []
      @validations << { name: value, type: validation_type, option: option }
    end
  end

  module InstanceMethods
    def validate_presence(value, _option)
      raise 'Значение - nil, или пустая строка' if [nil, ''].include?(value)
    end

    def validate_format(value, option)
      raise NameError, 'Неверный формат' if value.to_s !~ option
    end

    def validate_type(value, option)
      raise TypeError, 'Неверный тип' if value.class != option
    end

    def validate!
      self.class.validations_array.each do |validation|
        send "validate_#{validation[:type]}", instance_variable_get(validation[:name]), validation[:option].first
      end
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end
  end
end
