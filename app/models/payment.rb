class Payment < ActiveRecord::Base
  belongs_to :user
  PAYMENT_TO_KARMA = {
    5 => 5,
    15 => 20,
    25 => 40
  }

  def karma
    PAYMENT_TO_KARMA[payment_amount]
  end
end