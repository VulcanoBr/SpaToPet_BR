class AppointmentsController < ApplicationController
  before_action :set_appointment, only: %i[ show edit update destroy ]

  # GET /appointments or /appointments.json
  def index
    @appointments = Appointment.all
  end

  # GET /appointments/1 or /appointments/1.json
  def show
  end

  # GET /appointments/new
  def new
    @appointment = Appointment.new
    appointment_type = params[:appointment_type].gsub("-", " ")
    @appointment_type = AppointmentType.find_by(name: appointment_type)
    @appointment.payments.build # This line is added to the new action to build a payment object for the appointment.
  end

  # GET /appointments/1/edit
  def edit
  end

  # POST /appointments or /appointments.json
  def create
    @appointment = current_user.appointments.new(appointment_params.merge(client: current_user))
    @appointment_type = AppointmentType.find(params[:appointment][:appointment_type_id])

    respond_to do |format|
      if @appointment.save
        format.html { redirect_to appointment_url(@appointment), notice: "Appointment was successfully created." }
        format.json { render :show, status: :created, location: @appointment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /appointments/1 or /appointments/1.json
  def update
    respond_to do |format|
      if @appointment.update(appointment_params)
        format.html { redirect_to appointment_url(@appointment), notice: "Appointment was successfully updated." }
        format.json { render :show, status: :ok, location: @appointment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appointments/1 or /appointments/1.json
  def destroy
    @appointment.destroy!

    respond_to do |format|
      format.html { redirect_to appointments_url, notice: "Appointment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def appointment_params
      params.require(:appointment).permit(
        :status, :appointment_type_id,
        :start_at, :end_at,
        :notes, :pet_id, :local_id,
        payments_attributes: [:id, :billing_status, :user_id, :receipt, :_destroy]
      )
    end
end
