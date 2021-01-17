class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    @users = User.all

    render 'users/index', status: :created
  end

  # GET /users/1
  def show
    render 'users/show', status: :created
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render 'users/show', status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.fetch(:user, {})
    end
end
