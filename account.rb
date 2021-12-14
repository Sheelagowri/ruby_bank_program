# frozen_string_literal: true

# Account
class Account
  attr_accessor :number, :transactions, :balance

  def initialize
    @number = rand(100_000_000)
    @transactions = []
    @balance = 0
  end
end
