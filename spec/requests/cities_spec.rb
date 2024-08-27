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

RSpec.describe "/cities", type: :request do
  let(:user) { User.create!(first_name: "John Doe", last_name: "Vulcan", username: "Vulcano",
                  phone: "(21)98897-5959", email: "john@example.com", password: "123456", role: 2) }
  # This should return the minimal set of attributes required to create a valid
  # City. As you add validations to City, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do {
      name: "Minha cidade"
    }
  end

  let(:invalid_attributes) do {
      name: nil
    }
  end

  let(:new_attributes) do {
      name: "Minha cidade alterada"
    }
  end

  before do
    # Simular login do usuário
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  describe "GET /index" do
    it "renders a successful response" do
      City.create! valid_attributes
      get cities_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      city = City.create! valid_attributes
      get city_url(city)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_city_url
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      city = City.create! valid_attributes
      get edit_city_url(city)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new City" do
        expect {
          post cities_url, params: { city: valid_attributes }
        }.to change(City, :count).by(1)
      end

      it "redirects to the created city" do
        post cities_url, params: { city: valid_attributes }
        expect(response).to redirect_to(city_url(City.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new City" do
        expect {
          post cities_url, params: { city: invalid_attributes }
        }.to change(City, :count).by(0)
      end

    
      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post cities_url, params: { city: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do

      it "updates the requested city" do
        city = City.create! valid_attributes
        patch city_url(city), params: { city: new_attributes }
        city.reload
        expect(response).to have_http_status(302)
      end

      it "redirects to the city" do
        city = City.create! valid_attributes
        patch city_url(city), params: { city: new_attributes }
        city.reload
        expect(response).to redirect_to(city_url(city))
      end
    end

    context "with invalid parameters" do
    
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        city = City.create! valid_attributes
        patch city_url(city), params: { city: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested city" do
      city = City.create! valid_attributes
      expect {
        delete city_url(city)
      }.to change(City, :count).by(-1)
    end

    it "redirects to the cities list" do
      city = City.create! valid_attributes
      delete city_url(city)
      expect(response).to redirect_to(cities_url)
    end
  end
end
