class Transaction < ApplicationRecord

    validates :symbol, presence: true
    validates :stock_id, presence: true
    validates :total_shares, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :shares, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :price, presence: true, numericality: { greater_than_or_equal_to: 0.01 } 
    
   
    #belongs_to :user
    
    belongs_to :broker, class_name: "User"
    belongs_to :buyer, class_name: "User" 
end
