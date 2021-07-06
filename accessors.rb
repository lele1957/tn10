module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      history = []
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |value|
        instance_variable_set(var_name, value)
        history << value
      end
      define_method("#{name}_history") { history }
    end
  end

  def strong_attr_accessor(attribute, class_name)
    var_attr = "@#{attribute}".to_sym
    define_method(attribute) { instance_variable_get(var_attr) }
    define_method("#{attribute}=".to_sym) do |value|
      if value.is_a? class_name
        instance_variable_set(var_attr, value)
      else
        raise 'Invalid class type'
      end
    end
  end
end