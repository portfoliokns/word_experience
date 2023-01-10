require 'rails_helper'

RSpec.describe "Etrobocons", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/etrobocons/index"
      expect(response).to have_http_status(:success)
    end
  end

end
