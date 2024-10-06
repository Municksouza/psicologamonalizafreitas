require 'rails_helper'

RSpec.describe "Patients::Sessions", type: :request do
  describe "GET /index" do
    it "returns a successful response" do
      get new_patient_session_path
      expect(response).to have_http_status(:success)
    end
  end
end
