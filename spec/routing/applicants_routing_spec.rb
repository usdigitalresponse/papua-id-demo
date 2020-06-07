require "rails_helper"

RSpec.describe ApplicantsController, type: :routing do
  describe "routing" do
    it "does not route to #index" do
      expect(get: "/applicants").not_to route_to("applicants#index")
    end

    it "routes to #new" do
      expect(get: "/applicants/new").to route_to("applicants#new")
    end

    it "does not route to #show" do
      expect(get: "/applicants/1").not_to route_to("applicants#show", id: "1")
    end

    it "does not route to #edit" do
      expect(get: "/applicants/1/edit").not_to route_to("applicants#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/applicants").to route_to("applicants#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/applicants/1").to route_to("applicants#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/applicants/1").to route_to("applicants#update", id: "1")
    end

    it "does not route to #destroy" do
      expect(delete: "/applicants/1").not_to route_to("applicants#destroy", id: "1")
    end
  end
end
