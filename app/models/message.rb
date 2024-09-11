class Message < ApplicationRecord
  belongs_to :psychologist
  belongs_to :patient
  belongs_to :sendable, polymorphic: true
  belongs_to :chatroomable, polymorphic: true

  validates :date, presence: true
end
