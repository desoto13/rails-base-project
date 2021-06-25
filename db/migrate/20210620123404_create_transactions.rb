class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.string :symbol
      t.decimal :price
      t.integer :total_shares
      t.integer :shares
      t.string :buyer
      t.string :broker

      t.references :user
      t.references :stock
      t.timestamps
    end
  end
end
