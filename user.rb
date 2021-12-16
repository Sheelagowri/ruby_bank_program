# frozen_string_literal: true

require './transaction'
require './account'

# User
class User
  @users = []
  attr_accessor :email, :password, :account

  # keyword params
  def initialize(email:, password:, account:)
    @email = email
    @password = password
    @account = account
  end

  def self.create(email, password)
    user = User.new(email: email, password: password,
                    account: Account.new)
    @users << user
    user
  end

  def self.find_with_password(email, password)
    @users.detect { |user| user.email == email && user.password == password }
  end

  def add_transaction(type, amount)
    txn = Transaction.new(type, amount)
    account.transactions << txn
    account.balance += type == 'deposit' ? amount : -1 * amount
    puts "your amount #{amount} has been deposited successfully" if type == 'deposit'
    puts "your amount #{amount} has been withdraw successfully" if type == 'withdraw'
  end

  def find_balance
    account.balance
  end

  def list_transtions
    puts 'your Transaction history'
    history = account.transactions.map { |x| { type: x.type, amount: x.amount, time: x.time } }
    puts history
  end
end
