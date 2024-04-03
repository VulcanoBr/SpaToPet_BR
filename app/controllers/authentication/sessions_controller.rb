class Authentication::SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by("email = :login OR username = :login", { login: params[:login] })
    if @user.blank? || !@user.authenticate(params[:password])
      flash[:alert] = "Invalid login credentials"
      render :new, status: :unauthorized
      
    else
      login @user
      redirect_to root_path, notice: "Logged in successfully"
    end
  end

  def destroy
    logout current_user
    redirect_to root_path, notice: "Logged out successfully"
  end
end
