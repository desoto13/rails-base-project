class BrokersController < ApplicationController
  
  before_action :authenticate_user!, only: [:stocklist, :update_brokerstock]
  before_action :require_admin, only: [:show, :new, :create, :edit, :update, :destroy]

  def stocklist
    @stocklist = Stock.all
  end

  def update_brokerstock
    @stock = Stock.find(params[:id])
    current_user.brokerstocks.create(@stock)
    current_user.save

    redirect_to
  end

  def transactions
    @current_user_transactions = current_user.transactions
  end

  before_action :require_admin

  

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
