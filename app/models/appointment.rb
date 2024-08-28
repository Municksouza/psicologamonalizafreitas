class Appointment < ApplicationRecord
  belongs_to :psychologist
  belongs_to :patient, optional: true

  validates :date, presence: true
end
