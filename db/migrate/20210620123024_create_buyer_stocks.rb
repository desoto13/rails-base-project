class CreateBuyerStocks < ActiveRecord::Migration[6.0]
  def change
    create_table :buyer_stocks do |t|
      t.string :symbol
      t.decimal :curr_price
      t.decimal :bought_price
      t.decimal :change_price
      t.decimal :gains_loss
      t.integer :shares, default: 0
      t.text :info
      
      t.references :buyer

      t.timestamps
    end
  end
end
