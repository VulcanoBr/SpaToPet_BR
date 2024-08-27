class PaymentMailer < ApplicationMailer
  def send_payment_receipt(appointment_id)
    @appointment = Appointment.find_by(id: appointment_id)
    @payment = Payment.find_by(appointment_id: appointment_id)
    @user = User.find_by(id: @appointment.client_id)

    mail(to: "from@example.com", from: @user.email,
        subject: "Pagamento realizado - Agendamento #{@appointment.appointment_code}")
  end

  def send_return_approved(appointment_id)
    @appointment = Appointment.find_by(id: appointment_id)
    @payment = Payment.find_by(appointment_id: appointment_id)
    @user = User.find_by(id: @appointment.client_id)
    mail(to: @user.email, subject: 'Seu pagamento foi aprovado')
  end

  def send_return_unapproved(appointment_id)
    @appointment = Appointment.find_by(id: appointment_id)
    @payment = Payment.find_by(appointment_id: appointment_id)
    @user = User.find_by(id: @appointment.client_id)
    mail(to: @user.email, subject: 'Seu pagamento não foi aprovado')
  end
end
