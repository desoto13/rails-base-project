require 'rails_helper'

RSpec.describe Stock, type: :model do
  let!(:stock) { Stock.new }

  context 'validations' do
    it 'is not valid without symbol' do
      stock.price = 10.2
      stock.symbol = nil

      expect(stock).to_not be_valid
      expect(stock.errors).to be_present
      expect(stock.errors.to_h.keys).to include(:symbol)

    end

    it 'price is not valid ' do
      stock.price = 0
      stock.symbol = 'fb'

      expect(stock).to_not be_valid
      expect(stock.errors).to be_present
      expect(stock.errors.to_h.keys).to include(:price)

    end
  end
end
