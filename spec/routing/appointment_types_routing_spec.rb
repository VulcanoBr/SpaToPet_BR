require "rails_helper"

RSpec.describe AppointmentTypesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/appointment_types").to route_to("appointment_types#index")
    end

    it "routes to #new" do
      expect(get: "/appointment_types/new").to route_to("appointment_types#new")
    end

    it "routes to #show" do
      expect(get: "/appointment_types/1").to route_to("appointment_types#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/appointment_types/1/edit").to route_to("appointment_types#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/appointment_types").to route_to("appointment_types#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/appointment_types/1").to route_to("appointment_types#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/appointment_types/1").to route_to("appointment_types#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/appointment_types/1").to route_to("appointment_types#destroy", id: "1")
    end
  end
end
