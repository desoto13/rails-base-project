require 'rails_helper'

RSpec.describe BrokerStock, type: :model do
  let!(:brokerstock) { described_class.new }

  context 'validations' do
    it 'is not valid without symbol' do
      brokerstock.symbol = nil
      brokerstock.price = 10.2
      brokerstock.total_sold = 10

      expect(brokerstock).not_to be_valid
      expect(brokerstock.errors).to be_present
      expect(brokerstock.errors.to_h.keys).to include(:symbol)
    end

    it ' is not valid with incorrect price' do
      brokerstock.symbol = nil
      brokerstock.price = 0
      brokerstock.total_sold = 10

      expect(brokerstock).not_to be_valid
      expect(brokerstock.errors).to be_present
      expect(brokerstock.errors.to_h.keys).to include(:price)
    end

    it ' is not valid with incorrect total sold' do
      brokerstock.symbol = nil
      brokerstock.price = 10.2
      brokerstock.total_sold = -1

      expect(brokerstock).not_to be_valid
      expect(brokerstock.errors).to be_present
      expect(brokerstock.errors.to_h.keys).to include(:total_sold)
    end
  end
end
