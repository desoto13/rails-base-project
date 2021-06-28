class BuyerStock < ApplicationRecord
  validates :symbol, presence: true
  validates :curr_price, presence: true, numericality: { greater_than_or_equal_to: 0.01 }
  validates :bought_price, presence: true, numericality: { greater_than_or_equal_to: 0.01 }
  validates :change_price, presence: true, numericality: { greater_than_or_equal_to: 0.01 }
  validates :gains_loss, presence: true, numericality: { greater_than_or_equal_to: 0.01 }
  validates :shares, presence: true, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :buyer
end
