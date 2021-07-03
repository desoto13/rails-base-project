class BrokersController < ApplicationController
  
  before_action :authenticate_user!, only: [:index, :stocklist, :add_stock, :transactions]
  before_action :require_admin, only: [:show, :new, :create, :edit, :update, :destroy]

  def index
    @brokerstocks = current_user.brokerstocks.all
  end

  def stocklist
    client = IEX::Api::Client.new()
    brokerstocks = current_user.brokerstocks
    @stocklist = Stock.all
    
    @stocklist.each do |stock|
      quote = client.quote(stock.symbol)
      stock.price = quote.latest_price
    end
  end

  def add_stock
    @stock = Stock.find(params[:id])
    @current_user_brokerstocks = current_user.brokerstocks.new
    @current_user_brokerstocks.symbol = @stock.symbol
    @current_user_brokerstocks.price = @stock.price
    @current_user_brokerstocks.total_sold = 0
    @current_user_brokerstocks.info = @stock.info
    @current_user_brokerstocks.broker_id = current_user.id
    if @current_user_brokerstocks.save
      @success = "Successfully added stock to portfolio"
      redirect_to(stocklist_path, notice: @success)
    else
      @error = "Error broker stock add, please try again"
      redirect_to(stocklist_path, alert: @error)
    end
  end

  def remove_stock
    brokerstock = BrokerStock.find(params[:id])
    brokerstock.destroy

    redirect_to root_path
  end

  def transactions
    @current_user_transactions = Transaction.where(broker: current_user.username)
  end
  

  def show
    @broker = Broker.find(params[:id])
  end

  def new
    @broker = Broker.new
  end

  def create
    @broker = Broker.new(broker_params)
    if @broker.valid?
      @broker.save
      redirect_to @broker
    else
      render :new
    end
  end

  def edit
    @broker = Broker.find(params[:id])
  end

  def update
    @broker = Broker.find(params[:id])

    if @broker.update(broker_params)
      redirect_to @broker
    else
      render :edit
    end
  end

  def destroy
    @broker = Broker.find(params[:id])
    @broker.destroy

    redirect_to root_path
  end

  

  private

  def broker_params
    params.require(:broker).permit(:email, :password, :username)
  end
end
