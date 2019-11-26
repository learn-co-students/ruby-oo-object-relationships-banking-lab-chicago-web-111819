class Transfer

  attr_accessor :receiver, :sender, :amount, :status, :transfer_count, :last_transfer_amt

  def initialize(sender, receiver, amount)
      @sender = sender
      @receiver = receiver
      @amount = amount
      @status = "pending"
      @transfer_count = 0
      @last_transfer_amt = 0
  end

  def valid?
      (self.sender.valid? && self.receiver.valid?) ? true : false
  end

  def execute_transaction
    if transfer_count < 1
      if valid?
        if @sender.balance >= @amount
          @sender.balance -= @amount
          @receiver.balance += @amount

          # keeping track of transaction amount transfered
          @last_transfer_amt = @amount

          self.status = "complete"
          self.transfer_count = 1
        else
          self.status = "rejected"
          return "Transaction rejected. Please check your account balance."
        end
      else
        self.status = "rejected"
        return "Transaction rejected. Please check your account balance."
      end
    end
  end

  def reverse_transfer
    if transfer_count == 1
      @sender.balance += @last_transfer_amt
      @receiver.balance -= @last_transfer_amt
      self.status = "reversed"
      self.transfer_count = 0
    end
  end

end
