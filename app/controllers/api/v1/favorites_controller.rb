class Api::V1::FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    Rails.logger.debug(current_user.as_json)
    @favorites =  current_user.favorites

    render json: {result: @favorites}
  end

  def create
    @favorite = current_user.favorites.new(favorite_params)

    if @favorite.save
      render json: { result: @favorite.as_json }, status: :created
    else
      render json: { result: @favorite.as_json, errors: @favorite.errors }, status: :bad_request
    end
  end

  def destroy
    @favorite = current_user.favorites.find_by(id: params[:id])

    if @favorite  && @favorite.destroy
      render json: { result: @favorite }, status: :ok
    else
      render json: { result: @favorite, errors: @favorite&.errors || ['Record not found'] }, status: :bad_request
    end
  end

  # def show
  #   @favorite = Favorite.find_by(params[:id])

  #   render json: { result: @favorite.as_json }
  # end

  private

  def favorite_params
    params.permit(:ref_id, :title, :price, :image, :item_type, :url, :num_favorers)
  end
end
