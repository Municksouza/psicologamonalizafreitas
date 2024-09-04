class PsychologistChatroom < ApplicationRecord
  has_many :messages, as: :chatroomable
  belongs_to :psychologist
end
