require 'rails_helper'

RSpec.describe 'appointments/index', type: :view do
  let(:user) do
    User.create!(first_name: 'John Doe', last_name: 'Vulcan', username: 'Vulcano',
                 phone: '(21)98897-5959', email: 'john@example.com', password: '123456', role: 2)
  end
  let(:city) { City.create!(name: 'Cidade dea Luz') }
  let(:local) { Local.create!(city:, address: 'Endereço de terste') }
  let(:appointment_type) do
    AppointmentType.create!(name: 'Name test', payment_required: false,
                            user:, price: 123, color: 'Azul')
  end
  let(:pet) { Pet.create!(name: 'Nome Teste', breed: 'breed', kind: 1, user:) }
  let(:current_user) { user }
  let(:pagy) { Pagy.new(count: 2, items: 1) }
  before(:each) do
    @appointments = [
      Appointment.create!(
        appointment_code: DateTime.now.strftime('%Y%m%d%H%M%S') + rand(0..9).to_s,
        status: 0,
        appointment_type:,
        local:,
        pet:,
        client: user,
        start_at: Date.today,
        end_at: Date.today
      ),
      Appointment.create!(
        appointment_code: DateTime.now.strftime('%Y%m%d%H%M%S') + rand(0..9).to_s,
        status: 0,
        appointment_type:,
        local:,
        pet:,
        client: user,
        start_at: Date.today,
        end_at: Date.today
      )
    ]

    @appointment = @appointments.first # Aqui está a definição de @appointment

    assign(:pagy, pagy)
    assign(:appointments, @appointments)

    assign(:payments, [
             Payment.create!(
               billing_status: :unapproved,
               user_id: user.id,
               appointment: @appointment # Usando a primeira consulta da @appointments
             ),
             Payment.create!(
               billing_status: :unapproved,
               user_id: user.id,
               appointment: @appointments.last
             )
           ])
  end

  it 'renders a list of appointments' do
    render

    assert_select 'h1', text: 'Appointments'
    assert_select 'table tbody tr', count: 2

    # Use I18n.t para corresponder ao texto renderizado
    assert_select 'th', text: I18n.t('appointment_code')
    assert_select 'th', text: I18n.t('status')
    assert_select 'th', text: I18n.t('pet_name')
    assert_select 'th', text: I18n.t('breed')
    assert_select 'th', text: I18n.t('kind')
  end
end
