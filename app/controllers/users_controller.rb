class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    if @user.nil?
      redirect_to root_path
    end
    @appointments = current_user.appointments.order(created_at: :desc)
    @pagy, @appointments = pagy(@appointments, items: 12)
  end

  # DELETE /appointments/1 or /appointments/1.json
  def destroy
    @appointment = Appointment.find(params[:id])
    @appointment.destroy!

    respond_to do |format|
      format.html { redirect_to profile_url(current_user.id), notice: "Appointment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

end
