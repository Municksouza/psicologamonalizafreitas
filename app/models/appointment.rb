class Appointment < ApplicationRecord
  belongs_to :psychologist
  belongs_to :patient, optional: true # Appointment can exist without a patient initially

  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :end_after_start

  enum status: { available: 0, booked: 1, canceled: 2 }

  # Custom validation method to ensure end time is after start time
  def end_after_start
    return if end_time.blank? || start_time.blank?

    if end_time <= start_time
      errors.add(:end_time, "must be after the start time")
    end
  end
end
