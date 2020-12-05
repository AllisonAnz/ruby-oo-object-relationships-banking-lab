class Transfer
  attr_accessor :status
  attr_reader :amount, :sender, :receiver
  
  #can initialize a Transfer
  #initializes with a sender
  #always initializes with a status of 'pending'
  #initializes with a transfer amount
  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  #can check that both accounts are valid
  #calls on the sender and receiver's #valid? method
  def valid?
    sender.valid? && receiver.valid?
  end

  #can execute a successful transaction between two accounts
  #each transfer can only happen once
  #reject a transfer if the sender does not have enough funds
  def execute_transaction
    if valid? && sender.balance > amount && self.status == "pending"
      sender.balance -= amount
      receiver.balance += amount
      self.status = "complete"
    else
      reject_transfer
    end
  end

    def reject_transfer
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    end

    #reverse_transfer between two accounts
    #if can only reverse executed transfers
    def reverse_transfer
      if valid? && receiver.balance > amount && self.status == "complete"
        receiver.balance -= amount
        sender.balance += amount
        self.status = "reversed"
      else
        reject_transfer
      end
    end
  end
