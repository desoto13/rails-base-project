class BrokerStock < ApplicationRecord
  validates :symbol, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0.01 }
  validates :total_sold, presence: true, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :user
end
