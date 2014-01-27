# Project 15:

# In Project 11 you created a simple ATM program. However, the program was missing a lot of error check functionality.

# For example, the program wouldn’t work if you did something like this:

# a = Account.new
# a.account_holder = ‘Steve’
# a.deposit(‘$40.45’)

# Make a copy of Project 11 and then modify your ATM program to do the following:
# 1. Allow for decimal values i.e. a.deposit(30.35)
# 2. Allow for the user to put a dollar sign in front of the dollar amount i.e. a.deposit(‘$55.34’)
# 3. Don’t allow the user to withdraw/transfer more money than is in the account
# 4. Handle invalid input. i.e. a.deposit(‘cows’), a.account_holder=nil, a.withdraw(-55)

class Account
   attr_accessor :balance, :account_holder
    def initialize
     @balance = 0
    end
    def deposit(amount)
      if amount.is_a? String
        amount = amount.gsub(/^\$/, '').to_f
      end
      if amount > 0  
      @balance += amount
      else
        puts "Invalid input"
      end
    end

    def withdraw(amount)
      if amount.is_a? String
        amount = amount.gsub(/^\$/, '').to_f
      end
      raise 'Insufficient Funds' if amount > @balance
      if amount > 0 
        @balance -= amount
      else
        puts "Invalid input"
      end
    end
    
    def self.transfer(amount, from_account, to_account)
      if amount.is_a? String
        amount = amount.gsub(/^\$/, '').to_f
      end
      if amount > 0
        from_account.withdraw(amount)
        to_account.deposit(amount)
      else
        puts "Invalid input"
      end
    end
end

naly = Account.new
naly.deposit('$100') # => 100.0
naly.deposit('$100.75') # => 200.75
naly.deposit(200.25) # => 401.0
naly.deposit('$-50') # => Invalid input
naly.deposit(-100) # => Invalid input
puts naly.balance # => 401.0

naly.withdraw(100) # => 301.0
naly.withdraw('$1') # => 300.0
naly.withdraw -50 # => Invalid input
naly.withdraw('$500') # => Insufficient Funds
puts naly.balance # => 300.0

tahiry = Account.new
tahiry.deposit('$1000') # => 1000.0
puts tahiry.balance # => 1000.0

Account.transfer(500, tahiry, naly)
puts naly.balance # => 800.0
puts tahiry.balance # => 500.0

Account.transfer(130.50, naly, tahiry)
puts naly.balance # => 669.5
puts tahiry.balance # => 630.5

Account.transfer(100, naly, tahiry)
# => Insufficient fund
Account.transfer(-50, naly, tahiry)
# => Invalid input


# Resources:

# Tips:
# Remember in previous projects you studied about “Exceptions”? You could raise an exception if the user puts in invalid data (ie. step 4).

# You could also tell the user the input was invalid by printing a message to the screen. I.e. (‘You have requested to withdraw more money than is in the account’, or ‘The deposit amount you specified needs to be a number’), etc...

# Things to Google:
# Ruby how to strip out non-numbers from a ruby string
# Ruby how to convert a string to a number

# Why this project?:
# In the real world, you want to allow your programs to be flexible. If this program was a website, you may want to allow a user to deposit money using a variety of ways. For example, you could allow them to deposit by putting in 50 as the number, or $50.

# Also, in the real world, users don’t always enter data in a clean format, so our program needs to look for invalid input and inform the user why their input is invalid.
