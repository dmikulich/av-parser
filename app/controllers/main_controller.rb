class MainController < ApplicationController
  def index
    #@objects = Ad.includes(:seller, :auto).sort_by(&:ad_date).reverse.page(params[:page])  #.sort_by {|a| a.auto.year}.reverse
    @objects = Ad.page(params[:page]).per_page(20)
  end
end
