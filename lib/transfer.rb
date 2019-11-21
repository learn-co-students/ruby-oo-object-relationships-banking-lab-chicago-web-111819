#require_relative "bank_account.rb"

class Transfer
  attr_reader :receiver, :sender, :amount
  attr_accessor :status
  
  def initialize(sender, receiver, amount)
    @receiver = receiver
    @sender = sender
    @amount = amount
    @status = "pending"
  end

  def valid?
    @sender.valid?
    @receiver.valid?
  end

  def execute_transaction
    if self.status == "pending"
      if @sender.balance >= @amount && self.valid?
        @sender.balance -= @amount
        @receiver.balance += @amount
        self.status = "complete"
      else
        self.status = "rejected"
        "Transaction rejected. Please check your account balance."
      end
    end
  end

  def reverse_transfer
    if self.status == "complete"
      if @receiver.balance >= @amount && self.valid?
        @receiver.balance -= @amount
        @sender.balance += @amount
        self.status = "reversed"
      end
    end
  end
end
