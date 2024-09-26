class Appointment < ApplicationRecord
  belongs_to :psychologist
  belongs_to :patient, optional: true # Appointment can exist without a patient initially

  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :end_after_start

  enum :status, [ :available, :booked, :canceled ]
  scope :available, -> { where(patient_id: nil) }

  # Custom validation method to ensure end time is after start time
  def end_after_start
    return if end_time.blank? || start_time.blank?

    if end_time <= start_time
      errors.add(:end_time, "must be after the start time")
    end
  end
  
  def formatted_time_slot
    if start_time.present? && end_time.present?
      "#{start_time.strftime("%d-%m-%Y %H:%M")} - #{end_time.strftime("%H:%M")}"
    else
      "Time not set"
    end
  end

  def available?
    patient.nil?
  end

  def booked_by?(patient)
    self.patient == patient
  end
end
