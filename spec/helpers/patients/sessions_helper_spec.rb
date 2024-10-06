require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the Patients::SessionsHelper. For example:
#
# describe Patients::SessionsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end


RSpec.describe "Patients::Sessions", type: :request do
  describe "GET /new" do
    it "returns a successful response" do
      get new_patient_session_path
      expect(response).to have_http_status(:success)
    end
  end
end
