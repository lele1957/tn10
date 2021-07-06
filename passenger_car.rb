# frozen_string_literal: true

require_relative './company'
require_relative './instance_counter'
require_relative './accessors'
require_relative './validation'

class PassengerCar
  include Company
  include InstanceCounter
  extend Accessors

  attr_reader :type, :id, :seats_amount, :seats_taken
  attr_accessor_with_history :company
  strong_attr_accessor :test, String

  def initialize(id, seats_amount)
    @id = id
    @seats_amount = seats_amount
    @seats_taken = 0
    @type = 'passenger'
    register_instance
  end

  def take_seat
    @seats_taken += 1 if seats_taken < seats_amount
  end

  def free_seats
    @seats_amount - seats_taken
  end
end
