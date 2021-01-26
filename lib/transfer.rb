require 'pry'

class Transfer
  attr_accessor :status
  attr_reader :sender, :receiver, :amount

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = "pending"
    @amount = amount
  end

  def valid?
    if
    sender.valid? == true && receiver.valid? == true && sender.balance >= self.amount
      true
    else
      false
    end
  end

  def execute_transaction
    if self.status == "complete" || self.status == "rejected"
      sender.balance = sender.balance
      receiver.balance = receiver.balance
    elsif self.valid? == true
      sender.balance -= amount
      receiver.balance += amount
      self.status = "complete"
    else
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if self.status == "complete"
      sender.balance += amount
      receiver.balance -= amount
      self.status = "reversed"
    end
  end
end
