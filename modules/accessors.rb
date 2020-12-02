# frozen_string_literal: true

module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      atr_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(atr_name) }
      define_method("#{name}_history".to_sym) { instance_variable_get("@#{name}_history".to_sym) }
      define_method("#{name}=".to_sym) do |value|
        instance_variable_set(atr_name, value)
        instance_variable_get("@#{name}_history".to_sym) || instance_variable_set("@#{name}_history".to_sym, [])
        instance_variable_get("@#{name}_history".to_sym) << instance_variable_get("@#{name}")
      end
    end
  end

  def strong_attr_accessor(instance_name, instance_class)
    atr_name = "@#{instance_name}".to_sym
    define_method(instance_name) { instance_variable_get(atr_name) }
    define_method("#{instance_name}=".to_sym) do |value|
      raise if value.class != instance_class

      instance_variable_set(atr_name, value)
    end
  end
end
