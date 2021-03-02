class Transfer
  
  attr_accessor :sender, :receiver, :status, :amount

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = 'pending'
  end

  def valid?
    sender.valid? & receiver.valid?
  end

  def execute_transaction
    if self.status == 'pending'
      if self.receiver.status == 'closed' || self.sender.balance - self.amount < 0
        self.status = 'rejected'
        "Transaction rejected. Please check your account balance."
      else
        self.sender.deposit(-self.amount)
        self.receiver.deposit(self.amount)
        self.status = 'complete'
      end
    end
  end
     
  def reverse_transfer
    if self.status == 'complete' 
      self.receiver.deposit(-self.amount)
      self.sender.deposit(self.amount)
      self.status = 'reversed'
    end
  end

end
