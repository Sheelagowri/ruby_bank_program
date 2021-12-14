# frozen_string_literal: true

require 'date'

# Transaction
class Transaction
  attr_accessor :time, :type, :amount

  def initialize(type, amount)
    time = DateTime.now
    @time = time.ctime
    @type = type
    @amount = amount
  end
end
