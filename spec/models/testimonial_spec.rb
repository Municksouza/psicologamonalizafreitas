require "rails_helper"

RSpec.describe Testimonial, type: :model do
  describe 'validations' do
    it "is valid with valid attributes" do
      patient = create(:patient)
      psychologist = create(:psychologist)
      testimonial = Testimonial.new(content: "Great service", patient: patient, psychologist: psychologist)
      expect(testimonial).to be_valid
    end

    it "is not valid without content" do
      testimonial = Testimonial.new(content: nil)
      expect(testimonial).not_to be_valid
    end
  end
end
