require 'rails_helper'

RSpec.describe Transaction, type: :model do
  let!(:transaction) { described_class.new }

  context 'validations' do
    it 'is not valid without symbol' do
      transaction.symbol = nil
      transaction.stock_id = 2
      transaction.price = 10.2
      transaction.shares = 100
      transaction.total_shares = 100

      expect(transaction).not_to be_valid
      expect(transaction.errors).to be_present
      expect(transaction.errors.to_h.keys).to include(:symbol)
    end

    it 'is not valid without stock id' do
      transaction.symbol = 'fb'
      transaction.stock_id = nil
      transaction.price = 10.2
      transaction.shares = 100
      transaction.total_shares = 100

      expect(transaction).not_to be_valid
      expect(transaction.errors).to be_present
      expect(transaction.errors.to_h.keys).to include(:stock_id)
    end

    it ' is not valid with incorrect price' do
      transaction.symbol = 'fb'
      transaction.stock_id = 2
      transaction.price = 0
      transaction.shares = 100
      transaction.total_shares = 100

      expect(transaction).not_to be_valid
      expect(transaction.errors).to be_present
      expect(transaction.errors.to_h.keys).to include(:price)
    end

    it ' is not valid with incorrect shares' do
      transaction.symbol = 'fb'
      transaction.stock_id = 2
      transaction.price = 10.2
      transaction.shares = -1
      transaction.total_shares = 100

      expect(transaction).not_to be_valid
      expect(transaction.errors).to be_present
      expect(transaction.errors.to_h.keys).to include(:shares)
    end

    it ' is not valid with incorrect total shares' do
      transaction.symbol = 'fb'
      transaction.stock_id = 2
      transaction.price = 10.2
      transaction.shares = 100
      transaction.total_shares = -1

      expect(transaction).not_to be_valid
      expect(transaction.errors).to be_present
      expect(transaction.errors.to_h.keys).to include(:total_shares)
    end
  end
end
