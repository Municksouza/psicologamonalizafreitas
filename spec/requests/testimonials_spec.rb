require 'rails_helper'

RSpec.describe "Testimonials", type: :request do
  describe "GET /index" do
    it "returns a successful response" do
      get testimonials_path
      expect(response).to have_http_status(:success)
    end

    it "renders the index partial" do
      get testimonials_path
      expect(response).to render_template(partial: "_index") # Make sure this matches your partial name
    end

    it "loads all testimonials" do
      testimonial1 = create(:testimonial)
      testimonial2 = create(:testimonial)
      get testimonials_path
      expect(assigns(:testimonials)).to match_array([ testimonial1, testimonial2 ])
    end
  end
end
