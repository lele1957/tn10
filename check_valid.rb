# frozen_string_literal: true

module CheckValid
  def valid?
    validate!
    true
  rescue StandardError
    false
  end
end
