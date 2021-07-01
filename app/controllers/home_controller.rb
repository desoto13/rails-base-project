class HomeController < ApplicationController
  def index
    @users = User.where.not(type: 'Admin')
    @brokerstocklist = BrokerStock.all
    @buyerstocks = BuyerStock.all
  end
end
