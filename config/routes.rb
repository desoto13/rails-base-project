Rails.application.routes.draw do
  devise_for :admins
  get '/admins/approve/:id' => 'admins#approve', as: 'approve'
  get '/admins/approvals' => 'admins#approval', as: 'admin_broker_approval'
  get '/admins/transactions' => 'admins#transactions', as: 'admin_transactions'

  devise_for :brokers
  get '/brokers/stocklist' => 'brokers#stocklist', as: 'stocklist'
  get '/brokers/add_stock/:id' => 'brokers#add_stock', as: 'add_stock'
  get '/brokers/transactions' => 'brokers#transactions', as: 'broker_transactions'
  resources :brokers

  devise_for :buyers
  get '/buyers/brokerlist' => 'buyers#brokerlist', as: 'brokerlist'
  get '/buyers/broker_stocklist/:id' => 'buyers#broker_stocklist', as: 'broker_stocklist'
  get '/buyers/buy_stock/:id' => 'buyers#buy_stock', as: 'buy_stock'
  get '/buyers/transactions' => 'buyers#transactions', as: 'buyer_transactions'
  resources :buyers

  root 'home#index'

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
