class AppointmentsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_appointment, only: %i[show edit update destroy]

  # GET /appointments or /appointments.json
  def index
    @pagy, @appointments = pagy(FindAppointments.new.call(appointment_params_index), items: 10)
  end

  # GET /appointments/1 or /appointments/1.json
  def show
    @current_user = current_user
  end

  # GET /appointments/new
  def new
    @current_user = current_user
    @appointment = Appointment.new
    @local = params[:local_id]
    appointment_type = params[:appointment_type].gsub('-', ' ')
    @appointment_type = AppointmentType.find_by(name: appointment_type)
    @appointment.payments.build # This line is added to the new action to build a payment object for the appointment.
  end

  # GET /appointments/1/edit
  def edit
    @current_user = current_user
  end

  # POST /appointments or /appointments.json
  def create
    @appointment = current_user.appointments.new(appointment_params.merge(client: current_user))
    @appointment_type = AppointmentType.find(params[:appointment][:appointment_type_id])

    respond_to do |format|
      if @appointment.save
        format.html { redirect_to appointment_url(@appointment), notice: 'Appointment was successfully created.' }
        format.json { render :show, status: :created, location: @appointment }
      else
        @current_user = current_user
        @local = params[:appointment][:local_id]
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /appointments/1 or /appointments/1.json
  def update
    respond_to do |format|
      if @appointment.update(appointment_params)
        format.html { redirect_to appointment_url(@appointment), notice: 'Appointment was successfully updated.' }
      else
        @current_user = current_user
        @local = params[:appointment][:local_id]
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appointments/1 or /appointments/1.json
  def destroy
    @appointment.destroy!

    respond_to do |format|
      format.html { redirect_to appointments_url, notice: 'Appointment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def approval_appointment
    if params[:query_code].present?
      @pagy, @appointments = pagy(Appointment.with_payment_onapproval.search_by_code(params[:query_code]), items: 10)
    else
      @pagy, @appointments = pagy(Appointment.with_payment_onapproval, items: 10)
    end
  end

  def approval_payment
    @current_user = current_user
    @appointment = Appointment.find_by(id: params[:appointment_id])
  end

  def payment_approved
    @current_user = current_user
    @appointment = Appointment.find_by(id: params[:id])

    payments = Payment.find_by(appointment_id: params[:id])

    payments.approved!

    PaymentMailer.send_return_approved(@appointment.id).deliver_now
    flash[:notice] = 'Um email de aprovação foi enviado para o cliente'
    flash[:success] = 'Aprovação feita com sucesso !!!'
    redirect_to dashboard_admin_path
  end

  def payment_unapproved
    @current_user = current_user
    @appointment = Appointment.find_by(id: params[:id])
    payments = Payment.find_by(appointment_id: params[:id])

    payments.unapproved!

    PaymentMailer.send_return_unapproved(@appointment.id).deliver_now
    flash[:notice] = 'Um email foi enviado para o cliente, referente a não aprovação'
    flash[:success] = 'Pagamento não aprovado, com sucesso !!!!'
    redirect_to dashboard_admin_path
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
      :notes, :pet_id, :local_id, :client_id,
      payments_attributes: %i[id billing_status user_id receipt appointment_id _destroy]
    )
  end

  def appointment_params_index
    params.permit(:query_text, :status, :order_by)
  end
end
