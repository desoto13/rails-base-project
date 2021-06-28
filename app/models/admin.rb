class Admin < User
    has_many :brokerstock
    has_many :buyerstock
end
