class BrokersController < ApplicationController
  
  before_action :authenticate_user!, only: [:stocklist, :add_brokerstock]
  before_action :require_admin, only: [:show, :new, :create, :edit, :update, :destroy]

  def index
    @brokerstocks = BrokerStock.all
  end

  def stocklist
    @stocklist = Stock.all
    # @new_stocklist = stocklist.each do |stock|
    #   stock if stock.where.not() database of brokerstock && user.id ==current_user
    # end
  end

  def add_stock
    @stock = Stock.find(params[:id])
    @current_user_brokerstocks = current_user.brokerstocks.new
    @current_user_brokerstocks.symbol = @stock.symbol
    @current_user_brokerstocks.price = @stock.price
    @current_user_brokerstocks.total_sold = 0
    @current_user_brokerstocks.info = @stock.info
    @current_user_brokerstocks.broker_id = current_user.id
    @current_user_brokerstocks.save

    redirect_to stocklist_path
  end

  def transactions
    @current_user_transactions = current_user.transactions
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
