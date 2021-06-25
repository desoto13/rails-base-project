require 'rails_helper'

RSpec.describe BuyerStock, type: :model do
  let!(:buyerstock) { BuyerStock.new }

  context 'validations' do
    it 'is not valid without symbol' do
      buyerstock.symbol = nil
      buyerstock.curr_price = 10.2
      buyerstock.bought_price = 8
      buyerstock.change_price = 2.2
      buyerstock.gains_loss = 20
      buyerstock.shares = 100

      expect(buyerstock).to_not be_valid
      expect(buyerstock.errors).to be_present
      expect(buyerstock.errors.to_h.keys).to include(:symbol)

    end

    it ' is not valid with incorrect current price' do
      buyerstock.symbol = 'fb'
      buyerstock.curr_price = 0
      buyerstock.bought_price = 8
      buyerstock.change_price = 2.2
      buyerstock.gains_loss = 20
      buyerstock.shares = 100

      expect(buyerstock).to_not be_valid
      expect(buyerstock.errors).to be_present
      expect(buyerstock.errors.to_h.keys).to include(:curr_price)

    end

    it ' is not valid with incorrect bought price' do
      buyerstock.symbol = 'fb'
      buyerstock.curr_price = 10.2
      buyerstock.bought_price = 0
      buyerstock.change_price = 2.2
      buyerstock.gains_loss = 20
      buyerstock.shares = 100

      expect(buyerstock).to_not be_valid
      expect(buyerstock.errors).to be_present
      expect(buyerstock.errors.to_h.keys).to include(:bought_price)

    end

    it ' is not valid with incorrect change price' do
      buyerstock.symbol = 'fb'
      buyerstock.curr_price = 10.2
      buyerstock.bought_price = 8
      buyerstock.change_price = 0
      buyerstock.gains_loss = 20
      buyerstock.shares = 100

      expect(buyerstock).to_not be_valid
      expect(buyerstock.errors).to be_present
      expect(buyerstock.errors.to_h.keys).to include(:change_price)

    end

    it ' is not valid with incorrect gains loss' do
      buyerstock.symbol = 'fb'
      buyerstock.curr_price = 10.2
      buyerstock.bought_price = 8
      buyerstock.change_price = 2.2
      buyerstock.gains_loss = 0
      buyerstock.shares = 100

      expect(buyerstock).to_not be_valid
      expect(buyerstock.errors).to be_present
      expect(buyerstock.errors.to_h.keys).to include(:gains_loss)

    end

    it ' is not valid with incorrect shares' do
      buyerstock.symbol = 'fb'
      buyerstock.curr_price = 10.2
      buyerstock.bought_price = 8
      buyerstock.change_price = 2.2
      buyerstock.gains_loss = 20
      buyerstock.shares = -1

      expect(buyerstock).to_not be_valid
      expect(buyerstock.errors).to be_present
      expect(buyerstock.errors.to_h.keys).to include(:shares)

    end

  end
end
