# frozen_string_literal: true

require_relative 'user'
require 'io/console'

# Bank
class Bank
  def welcome
    puts 'Enter: L for login, or C for create new user, or e for exit'
    input = gets.chomp.downcase
    case input
    when 'l'
      login
      welcome
    when 'c'
      create_user
    when 'e'
      exit
    else
      puts 'Try again'
      welcome
    end
  end

  def login
    puts 'Enter Email id:'
    email = gets.chomp.to_s
    puts 'password'
    password = $stdin.noecho(&:gets).chomp
    @user = User.find_with_password(email, password)
    if @email == email && @password == password
      payment
    else
      puts 'Account does not exit! please check your email or password'
    end
  end

  def create_user
    puts 'Enter Email id:'
    @email = gets.chomp.to_s
    if @email =~ /^([a-z0-9_\-.]+).+@gmail.com/
      validate_password
    else
      puts 'Enter a valid email(example@gmail.com)'
      create_user
    end
  end

  def validate_password
    puts 'password'
    @password = gets.chomp
    if @password =~ /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/
      password_conformation
    else
      print 'Invalid password! Your password should have Minimum eight characters, at least one letter and one number'
      puts '(Note: should not have any special character)'
      validate_password
    end
  end

  def password_conformation
    puts 'confirm password'
    @confirm_password = gets.chomp
    if @confirm_password == @password
      @user = User.create(@email, @password)
      payment
      welcome
    else
      puts " password doesn't match"
      validate_password
    end
  end

  def transaction_type(type)
    puts 'Enter your transaction amount'
    amount = gets.chomp.to_i
    if type == 'deposit'
      deposit(amount)
    else
      withdraw(amount)
    end
    payment
  end

  def deposit(amount)
    if amount > 100
      @user.add_transaction('deposit', amount)
    else
      puts 'Enter valid amount, your amount should be greater than 100'
    end
  end

  def withdraw(amount)
    if amount >= 100 && amount <= @user.find_balance
      @user.add_transaction('withdraw', amount)
    else
      puts 'Enter valid amount, your amount should be greater than 100' if amount < 100
      puts 'Insufficient balance!' if @user.find_balance < amount
    end
  end

  def payment
    puts 'Enter: d for deposit, or w for withdraw, or B for balance, or H for transaction history, or E for exit'
    input = gets.chomp.downcase
    case input
    when 'd'
      transaction_type('deposit')
    when 'w'
      transaction_type('withdraw')
    when 'b'
      puts "your Account balance is $#{@user.find_balance}"
      payment
    when 'h'
      @user.list_transtions
      payment
    when 'e'
      exit
    else
      puts 'Try again'
      check_balance_and_history
    end
  end

  def exit
    puts 'Thank you!'
  end
end

Bank.new.welcome
