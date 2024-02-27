require "rails_helper"

RSpec.describe LocalsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/locals").to route_to("locals#index")
    end

    it "routes to #new" do
      expect(get: "/locals/new").to route_to("locals#new")
    end

    it "routes to #show" do
      expect(get: "/locals/1").to route_to("locals#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/locals/1/edit").to route_to("locals#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/locals").to route_to("locals#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/locals/1").to route_to("locals#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/locals/1").to route_to("locals#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/locals/1").to route_to("locals#destroy", id: "1")
    end
  end
end
