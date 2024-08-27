require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe '/appointments', type: :request do
  # This should return the minimal set of attributes required to create a valid
  # Appointment. As you add validations to Appointment, be sure to
  # adjust the attributes here as well.
  let(:user) do
    User.create!(first_name: 'John Doe', last_name: 'Vulcan', username: 'Vulcano',
                 phone: '(21)98897-5959', email: 'john@example.com', password: '123456', role: 0)
  end
  let(:city) { City.create!(name: 'Cidade dea Luz') }
  let(:local) { Local.create!(city: city, address: 'Endereço de terste') }
  let(:appointment_type) do
    AppointmentType.create!(name: 'Name test', payment_required: true,
                            user: user, price: 123, color: 'Azul')
  end
  let(:pet) { Pet.create!(name: 'Nome Teste', breed: 'breed', kind: 1, user: user) }
  let(:current_user) { user }
  let(:client_id) { user.id }
  let(:valid_attributes) do
    {
      appointment_code: DateTime.now.strftime('%Y%m%d%H%M%S') + rand(0..9).to_s,
      # status: 0,
      appointment_type_id: appointment_type.id,
      local_id: local.id,
      pet_id: pet.id,
      client_id: client_id,
      start_at: Date.today,
      end_at: Date.today
    }
  end

  let(:invalid_attributes) do
    {
      appointment_code: nil,
      # status: 0,
      appointment_type_id: appointment_type.id,
      local_id: nil,
      pet_id: nil,
      client_id: nil,
      start_at: nil,
      end_at: nil
    }
  end
  let(:payment_attributes) do
    {
      billing_status: :unapproved,
      user_id: user.id,
      appointment_id: nil
    }
  end

  let(:new_attributes) do
    {
      # status: 0,
      appointment_code: DateTime.now.strftime('%Y%m%d%H%M%S') + rand(0..9).to_s,
      appointment_type_id: appointment_type.id,
      local_id: local.id,
      pet_id: pet.id,
      client_id: client_id,
      start_at: Date.today + 1,
      end_at: Date.today + 2
    }
  end
  before(:each) do
    # @appointment_type = appointment_type
    # Simular login do usuário
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(current_user)
    @current_user = user
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      appointment = Appointment.create! valid_attributes
      payment_attributes[:appointment_id] = appointment.id
      payment = Payment.create! payment_attributes
      get appointments_url(appointment)
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      appointment = Appointment.create! valid_attributes
      get appointment_url(appointment)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_appointment_url, params: { appointment_type: appointment_type.name }
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      appointment = Appointment.create! valid_attributes
      get edit_appointment_url(appointment)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Appointment' do
        expect do
          post appointments_url, params: { appointment: valid_attributes }
        end.to change(Appointment, :count).by(1)
      end

      it 'redirects to the created appointment' do
        post appointments_url, params: { appointment: valid_attributes }
        expect(response).to redirect_to(appointment_url(Appointment.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Appointment' do
        expect do
          post appointments_url, params: { appointment: invalid_attributes }
        end.to change(Appointment, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post appointments_url, params: { appointment: invalid_attributes }
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      it 'updates the requested appointment' do
        appointment = Appointment.create! valid_attributes
        patch appointment_url(appointment), params: { appointment: new_attributes }
        appointment.reload
        expect(response).to have_http_status(302)
      end

      it 'redirects to the appointment' do
        appointment = Appointment.create! valid_attributes
        patch appointment_url(appointment), params: { appointment: new_attributes }
        appointment.reload
        expect(response).to redirect_to(appointment_url(appointment))
      end
    end

    context 'with invalid parameters' do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        appointment = Appointment.create! valid_attributes
        patch appointment_url(appointment), params: { appointment: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested appointment' do
      appointment = Appointment.create! valid_attributes
      expect do
        delete appointment_url(appointment)
      end.to change(Appointment, :count).by(-1)
    end

    it 'redirects to the appointments list' do
      appointment = Appointment.create! valid_attributes
      delete appointment_url(appointment)
      expect(response).to redirect_to(appointments_url)
    end
  end
end
