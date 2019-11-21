require_relative "bank_account.rb"

class Transfer

  attr_accessor :status
  attr_reader :sender, :receiver, :amount

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  def valid?
    @sender.valid? && @receiver.valid?
  end

  def execute_transaction
    if self.status == "complete"
      exit
    end
    if self.valid?
      @sender.balance -= @amount
      @receiver.balance += @amount
      self.status = "complete"
    else
      self.status = "rejected"
      return "Transaction rejected. Please check your account balance."
    end
   end

  def reverse_transfer
    if self.status == "complete" && self.valid?
      @sender.balance += amount
      @receiver.balance -= amount
      self.status = "reversed"
    end
  end
end
