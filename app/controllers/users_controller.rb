class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    if @user.nil?
      redirect_to root_path
    end
    @appointments = current_user.appointments.order(created_at: :desc)
  end
  
end