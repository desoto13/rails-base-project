class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.int :stock_id
      t.string :symbol
      t.decimal :price
      t.int :total_shares
      t.int :shares
      t.string :buyer
      t.string :broker

      t.timestamps
    end
  end
end
