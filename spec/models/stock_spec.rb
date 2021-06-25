require 'rails_helper'

RSpec.describe Stock, type: :model do
  let!(:stock) { described_class.new }

  context 'validations' do
    it 'is not valid without symbol' do
      stock.price = 10.2
      stock.symbol = nil

      expect(stock).not_to be_valid
      expect(stock.errors).to be_present
      expect(stock.errors.to_h.keys).to include(:symbol)
    end

    it 'is not valid with incorrect price' do
      stock.price = 0
      stock.symbol = 'fb'

      expect(stock).not_to be_valid
      expect(stock.errors).to be_present
      expect(stock.errors.to_h.keys).to include(:price)
    end
  end
end
