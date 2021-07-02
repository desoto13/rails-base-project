class HomeController < ApplicationController
  def index
    @users = User.where.not(type: 'Admin')
    @brokerstocks = BrokerStock.all
    @buyerstocks = BuyerStock.all
  end
end
