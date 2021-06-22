class CreateBrokerStocks < ActiveRecord::Migration[6.0]
  def change
    create_table :broker_stocks do |t|
      t.string :symbol
      t.decimal :price
      t.int :total_sold
      t.text :info
      t.int :user_id

      t.timestamps
    end
  end
end
