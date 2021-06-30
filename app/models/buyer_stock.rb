class BuyerStock < ApplicationRecord
  validates :symbol, presence: true
  validates :curr_price, presence: true, numericality: { greater_than_or_equal_to: 0.01 }
  validates :bought_price, presence: true
  validates :change_price, presence: true
  validates :gains_loss, presence: true
  validates :shares, presence: true, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :buyer
end
