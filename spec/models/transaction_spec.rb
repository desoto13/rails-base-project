require 'rails_helper'

RSpec.describe Transaction, type: :model do
  let!(:transaction) { Transaction.new }

  context 'validations' do
    it 'is not valid without symbol' do

      transaction.symbol = nil
      transaction.stock_id = 2
      transaction.price = 10.2
      transaction.shares = 100
      transaction.total_shares = 100
      
      expect(transaction).to_not be_valid
      expect(transaction.errors).to be_present
      expect(transaction.errors.to_h.keys).to include(:symbol)

    end

    it 'is not valid without stock id' do

      transaction.symbol = 'fb'
      transaction.stock_id = nil
      transaction.price = 10.2
      transaction.shares = 100
      transaction.total_shares = 100
      
      expect(transaction).to_not be_valid
      expect(transaction.errors).to be_present
      expect(transaction.errors.to_h.keys).to include(:stock_id)

    end

    it 'price is not valid' do

      transaction.symbol = 'fb'
      transaction.stock_id = 2
      transaction.price = 0
      transaction.shares = 100
      transaction.total_shares = 100
      
      expect(transaction).to_not be_valid
      expect(transaction.errors).to be_present
      expect(transaction.errors.to_h.keys).to include(:price)

    end

    it 'shares is not valid' do

      transaction.symbol = 'fb'
      transaction.stock_id = 2
      transaction.price = 10.2
      transaction.shares = -1
      transaction.total_shares = 100
      
      expect(transaction).to_not be_valid
      expect(transaction.errors).to be_present
      expect(transaction.errors.to_h.keys).to include(:shares)

    end

    it 'total shares is not valid' do

      transaction.symbol = 'fb'
      transaction.stock_id = 2
      transaction.price = 10.2
      transaction.shares = 100
      transaction.total_shares = -1
      
      expect(transaction).to_not be_valid
      expect(transaction.errors).to be_present
      expect(transaction.errors.to_h.keys).to include(:total_shares)

    end

  end
end
