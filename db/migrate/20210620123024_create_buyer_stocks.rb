class CreateBuyerStocks < ActiveRecord::Migration[6.0]
  def change
    create_table :buyer_stocks do |t|
      t.string :symbol
      t.decimal :curr_price
      t.decimal :bought_price
      t.decimal :change_price
      t.decimal :gains_loss
      t.int :shares
      t.text :info
      t.int :user_id

      t.timestamps
    end
  end
end
