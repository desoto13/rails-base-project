class Stock < ApplicationRecord
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0.01 }
  validates :symbol, presence: true

  has_many :transactions, dependent: :nullify
end
