class BuyersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :brokerlist, :broker_stocklist, :buy_stock, :transactions]
  before_action :require_admin, only: [:show, :new, :create, :edit, :update, :destroy]

  def index
    @buyerstocks = BuyerStock.all
    @stock = Stock.all
  end


  def brokerlist
    @brokers = Broker.all
  end

  def broker_stocklist
    @broker = Broker.find(params[:id])
    @broker_stockslist = @broker.brokerstocks.all
  end

  def buy_stock
    
    @brokerstock = BrokerStock.find(params[:id])

    #get data from stock model
    @stock = Stock.find_by(symbol: @brokerstock.symbol )
    # symbol = BuyerStock.where({symbol: @brokerstock.symbol, buyer_id: current_user.id})
    # puts symbol

    if BuyerStock.symbol.any? then
      
      @current_user_buyerstocks = current_user.buyerstocks.build
      @current_user_buyerstocks.symbol = @brokerstock.symbol
      @current_user_buyerstocks.curr_price = @stock.price
      @current_user_buyerstocks.bought_price = @brokerstock.price
      @current_user_buyerstocks.change_price = @stock.price - @brokerstock.price
      @current_user_buyerstocks.gains_loss = ((@stock.price-@brokerstock.price)/@brokerstock.price.abs)*100
      
      #increments brokerstock total sold
      # @brokerstock.update_attribute(:total_sold,((@brokerstock.total_sold+100)))
      @brokerstock.total_sold += 100
      @brokerstock.save
      
      @current_user_buyerstocks.curr_price +=100
      @current_user_buyerstocks.info = @brokerstock.info
      @current_user_buyerstocks.buyer_id = current_user.id 
      
      @current_user_buyerstocks.save
    # else
    #   symbol.curr_price += 100
    #   symbol.save
    # end

      @success = "Successfully bought stock to portfolio"
      redirect_to(buyers_path(@brokerstock.broker_id), alert: @success)
    # else
    #   @error = "Error in buying stock, please try again"
    #   redirect_to(broker_stocklist_path(@brokerstock.broker_id), alert: @error)
    # end

    
  end

  def transactions
    @current_user_transactions = current_user.transactions
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
end
