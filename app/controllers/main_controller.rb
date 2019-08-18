class MainController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    @objects = Auto.includes(:model, :ad, model: [:brand], ad: [:place, :seller]).search(params[:search]).order(sort_column + " " + sort_direction).page(params[:page]).per_page(20)
  end

  def phone_number
    seller = Seller.find(params[:id])
    render json: { phone: seller.phone_number }
  end

private

  def sort_column
    if Auto.column_names.include?(params[:sort])
      "autos.#{params[:sort]}"
    elsif Ad.column_names.include?(params[:sort])
      "ads.#{params[:sort]}"
    else
      "ads.ad_date"
    end
  end

  def sort_direction
    ["asc", "desc"].include?(params[:direction]) ? params[:direction] : "desc"
  end
end
