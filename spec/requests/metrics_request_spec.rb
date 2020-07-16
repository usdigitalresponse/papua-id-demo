require 'rails_helper'

RSpec.describe "Metrics", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/metrics/index"
      expect(response).to have_http_status(:success)
    end
  end

end
