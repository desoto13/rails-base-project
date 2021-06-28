class CreateBrokerStocks < ActiveRecord::Migration[6.0]
  def change
    create_table :broker_stocks do |t|
      t.string :symbol
      t.decimal :price
      t.integer :total_sold
      t.text :info

      t.references :broker

      t.timestamps
    end
  end
end
