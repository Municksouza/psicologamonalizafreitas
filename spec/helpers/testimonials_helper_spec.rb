require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the TestimonialsHelper. For example:
#
# describe TestimonialsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end

RSpec.describe TestimonialsHelper, type: :helper do
  describe '#some_helper_method' do
    it 'returns the expected value' do
      expect(helper.some_helper_method).to eq('expected value') # Update the expectation
    end
  end
end
