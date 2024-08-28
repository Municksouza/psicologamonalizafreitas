class Message < ApplicationRecord
  belongs_to :psychologist
  belongs_to :patient

  validates :date, presence: true
end
