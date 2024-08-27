class Authentication::UsersController < ApplicationController

  before_action :set_user, only: %i[ edit update ]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, notice: 'User was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to root_path, notice: 'User was successfully updated.'
    else
      flash[:alert] = "Problema na atualização"
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :first_name, :last_name,
      :email, :username,
      :phone, :password,
      :password_confirmation, :role,
      :avatar
    )
  end
end
