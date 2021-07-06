module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :valid_rules

    def validate(attr_name, type, *options)
      @valid_rules ||= []
      @valid_rules << { name: attr_name, type: type, options: options }
    end
  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue
      false
    end

    protected

    def validate!
      valid_rules = 
        if self.class.valid_rules.nil? && self.class.superclass.valid_rules.nil?
          []
        else
          self.class.valid_rules || self.class.superclass.valid_rules
        end

      valid_rules.each do |valid_rule|
        variable = instance_variable_get("@#{valid_rule[:name]}")
        send valid_rule[:type], variable, *valid_rule[:options]
      end
    end

    def presence(variable, *_option)
      raise 'Attribute cannot be nil' if variable.nil? || variable.empty?
    end

    def format(variable, regexp)
      raise "Attribute doesn't match regexp format" if variable !~ regexp
    end

    def type(variable, class_name)
      raise 'Wrong class of the attribute' unless variable.is_a? class_name
    end
  end
end