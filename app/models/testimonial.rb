class Testimonial < ApplicationRecord
  belongs_to :patient, optional: true
  belongs_to :psychologist, optional: true
  validates :content, presence: true
end
