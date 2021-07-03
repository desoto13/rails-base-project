class BuyersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :brokerlist, :broker_stocklist, :show_stock, :buy_stock, :transactions]
  before_action :require_admin, only: [:show, :new, :create, :edit, :update, :destroy]

  def index

    @buyerstocks = current_user.buyerstocks.all
    @stock = Stock.all
    client = IEX::Api::Client.new()
    @buyerstocks.each do |buyerstock|
      
      quote = client.quote(buyerstock.symbol)
      latest_price = quote.latest_price

      buyerstock.curr_price = latest_price
      buyerstock.change_price = latest_price - buyerstock.bought_price
      buyerstock.gains_loss = ((latest_price-buyerstock.bought_price)/buyerstock.bought_price.abs)*100
      buyerstock.gains_loss = buyerstock.gains_loss.truncate(2)
      buyerstock.save
    end
  end

  def brokerlist
    @brokers = Broker.all
  end

  def broker_stocklist
    client = IEX::Api::Client.new()

    @broker = Broker.find(params[:id])
    @broker_stockslist = @broker.brokerstocks.all
    @broker_stockslist.each do |stock|
      quote = client.quote(stock.symbol)
      stock.price = quote.latest_price
    end
  end

  def show_stock
    client = IEX::Api::Client.new()

    @brokerstock = BrokerStock.find(params[:id])
    @stock = Stock.find_by(symbol: @brokerstock.symbol)
    
    quote = client.quote(@brokerstock.symbol)
    @stock.price = quote.latest_price
    @stock.save
    @brokerstock.price = quote.latest_price
    @brokerstock.save
  end

  def buy_one
    buy_stock(1)
  end

  def buy_ten
    buy_stock(10)
  end

  def buy_hundred
    buy_stock(100)
  end

  def buy_thousand
    buy_stock(1000)
  end

  def transactions
    @current_user_transactions = Transaction.where(buyer: current_user.username)
  end

  def show
    @buyer = Buyer.find(params[:id])
  end

  def new
    @buyer = Buyer.new
  end

  def create
    @buyer = Buyer.new(buyer_params)
    if @buyer.valid?
      @buyer.save
      redirect_to @buyer
    else
      render :new
    end
  end

  def edit
    @buyer = Buyer.find(params[:id])
  end

  def update
    @buyer = Buyer.find(params[:id])

    if @buyer.update(buyer_params)
      redirect_to @buyer
    else
      render :edit
    end
  end

  def destroy
    @buyer = Buyer.find(params[:id])
    @buyer.destroy

    redirect_to root_path
  end

  private
  def broker_params
    params.require(broker).permit(:id)
  end

  def buyer_params
    params.require(:buyer).permit(:email, :password, :username)
  end

  def new_transaction(current_stock, broker_stock)
    broker_used = Broker.find_by(id: broker_stock.broker_id)

    trans = Transaction.new
    trans.symbol = broker_stock.symbol
    trans.price = broker_stock.price
    trans.total_shares = current_stock.shares
    trans.shares = 100
    trans.buyer = current_user.username
    trans.broker = broker_used.username
    trans.stock_id = current_stock.id
    trans.save
  end

  def buy_stock(num_shares)
    @brokerstock = BrokerStock.find(params[:id])
    @stock = Stock.find_by(symbol: @brokerstock.symbol)

    if current_user.buyerstocks.any? {|stock| stock.symbol == @brokerstock.symbol}
      current_stock = current_user.buyerstocks.find_by(symbol: @brokerstock.symbol)
      current_stock.shares += num_shares
      current_stock.save
      new_transaction(current_stock, @brokerstock)
    else
      @current_user_buyerstocks = current_user.buyerstocks.build
      @current_user_buyerstocks.symbol = @brokerstock.symbol
      @current_user_buyerstocks.curr_price = @stock.price
      @current_user_buyerstocks.bought_price = @brokerstock.price
      @current_user_buyerstocks.change_price = @stock.price - @brokerstock.price
      @current_user_buyerstocks.gains_loss = ((@stock.price-@brokerstock.price)/@brokerstock.price.abs)*100
      @current_user_buyerstocks.shares = num_shares
      
      @brokerstock.total_sold += num_shares
      @brokerstock.save
      
      @current_user_buyerstocks.curr_price = @brokerstock.price
      @current_user_buyerstocks.info = @brokerstock.info
      @current_user_buyerstocks.buyer_id = current_user.id 
      @current_user_buyerstocks.save

      new_transaction(@current_user_buyerstocks, @brokerstock)
    end

    @success = "Successfully bought stock to portfolio"
    redirect_to(buyers_path(@brokerstock.broker_id), notice: @success)
  end
end
