class Api::V1::UsersController < ApplicationController
  before_action :set_api_v1_user, only: [:show, :update, :destroy]
  before_action :authenticate_user!, except: [:create]

  # GET /api/v1/users/1
  def show
    render json: {result: @api_v1_user}
  end

  # POST /api/v1/users
  def create
    @api_v1_user = User.new(api_v1_user_params)

    if @api_v1_user.save
      render json: { result: @api_v1_user }, status: :created
    else
      render json: { result: @api_v1_user, errors: @api_v1_user.errors }, status: :unprocessable_entity
    end

  rescue => e
    render json: { result: @api_v1_user, errors: "Duplicate or other issues" }, status: :ok
  end

  # PATCH/PUT /api/v1/users/1
  def update
    if @api_v1_user.update(api_v1_user_params)
      render json: { result: @api_v1_user }
    else
      render json: @api_v1_user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/users/1
  def destroy
    @api_v1_user.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_api_v1_user
    @api_v1_user = User.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def api_v1_user_params
    params.permit(:email, :password, :password_confirmation)
  end
end