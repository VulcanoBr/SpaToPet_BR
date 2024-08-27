class AppointmentMailer < ApplicationMailer
  def send_appointment_canceled(appointment_id)
    @appointment = Appointment.find(appointment_id)
    @payment = Payment.find_by(appointment_id: appointment_id)
    @user = User.find_by(id: @appointment.client_id)
    mail(to: @user.email, subject: "Cancelamento do Agendamento- #{@rental.rented_code}")
  end
end
