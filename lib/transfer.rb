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
    self.sender.valid?
    self.receiver.valid?
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
      if @sender.balance >= @amount && self.valid?
        @sender.balance += @amount
        @receiver.balance -= @amount
        self.status = "reversed"
      else
        self.status = "rejected"
        "Transaction rejected. Please check your account balance."
      end
    end
  end

end