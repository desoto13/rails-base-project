class HomeController < ApplicationController
  def index
    @users = User.where.not(type: 'Admin')
    @brokerstocklist = BrokerStock.all
    @brokerstocklist = BuyerStock.all
  end
end
