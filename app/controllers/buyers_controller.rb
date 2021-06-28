class BuyersController < ApplicationController
  before_action :authenticate_user!, only: [:brokerlist, :brokerlist_stocks, :transactions]
  before_action :require_admin, only: [:show, :new, :create, :edit, :update, :destroy]

  def index
    @brokers = Broker.all
  end


  def brokerlist
    @stocklist = Broker.all
  end

  def brokerlist_stocks
    @broker_stockslist = Broker.find(broker_params)
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
    params.require(:broker).permit(:id)
  end

  def buyer_params
    params.require(:buyer).permit(:email, :password, :username)
  end
end
