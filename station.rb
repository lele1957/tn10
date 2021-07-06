# frozen_string_literal: true

require_relative './instance_counter'
require_relative './check_valid'
require_relative './validation'
class Station

  include InstanceCounter
  include CheckValid
  include Validation
  attr_reader :name, :trains

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    register_instance
    validate!
  end

  def type_amount(type)
    @trains.count { |train| train.type == type }
  end

  def add_train(train)
    @trains << train
  end

  def yield_train(&block)
    @trains.each(&block)
  end

  def train_departure(train)
    @trains.delete(train)
  end

  protected

  def validate!
    raise 'name cannot be nil' if name.nil?
    raise 'max name lenght 20' if name.length > 20
  end
end
