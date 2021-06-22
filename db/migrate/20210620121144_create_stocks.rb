class CreateStocks < ActiveRecord::Migration[6.0]
  def change
    create_table :stocks do |t|
      t.string :symbol
      t.decimal :price
      t.text :info

      t.timestamps
    end
  end
end
