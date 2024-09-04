class PatientChatroom < ApplicationRecord
  has_many :messages, as: :chatroomable
  belongs_to :patient
end
