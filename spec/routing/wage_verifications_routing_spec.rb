require "rails_helper"

RSpec.describe WageVerificationsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/wage_verifications").to route_to("wage_verifications#index")
    end

    it "routes to #new" do
      expect(get: "/wage_verifications/new").to route_to("wage_verifications#new")
    end

    it "routes to #show" do
      expect(get: "/wage_verifications/1").to route_to("wage_verifications#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/wage_verifications/1/edit").to route_to("wage_verifications#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/wage_verifications").to route_to("wage_verifications#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/wage_verifications/1").to route_to("wage_verifications#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/wage_verifications/1").to route_to("wage_verifications#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/wage_verifications/1").to route_to("wage_verifications#destroy", id: "1")
    end
  end
end
