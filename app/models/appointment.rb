class Appointment < ApplicationRecord
  belongs_to :psychologist
  belongs_to :patient, optional: true # Appointment can exist without a patient initially

  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :end_after_start
  validates :status, inclusion: { in: ['available', 'booked'] }

  enum status: { available: 0, booked: 1, canceled: 2 }
  scope :available, -> { where(status: :available, patient_id: nil) }
  scope :booked, -> { where(status: :booked) }

  after_save :send_notification_to_psychologist, if: -> { status_changed? && booked? }

  def send_notification_to_psychologist
    AppointmentMailer.with(appointment: self).new_booking_email.deliver_later
  end

  # Custom validation method to ensure end time is after start time
  def end_after_start
    if end_time <= start_time
      errors.add(:end_time, "deve ser depois da hora de início")
    end
  end

  def self.available_time_slots(date, start_hour = 8, end_hour = 18, duration_minutes = 45)
    slots = []
    current_time = date.to_time.change(hour: start_hour)

    while current_time < date.to_time.change(hour: end_hour)
      end_time = current_time + duration_minutes.minutes
      slots << [current_time, end_time]
      current_time = end_time
    end

    slots
  end

  def formatted_time_slot
    if start_time.present? && end_time.present?
      "#{start_time.strftime("%d-%m-%Y %H:%M")} - #{end_time.strftime("%H:%M")}"
    else
      "Time not set"
    end
  end

  def available?
    patient.nil? && status == "available"
  end


  def booked_by?(patient)
    self.patient == patient
  end
end
