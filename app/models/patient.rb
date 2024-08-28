class Patient < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :psychologist, optional: true
  has_many :appointments, dependent: :destroy
  has_many :messages, dependent: :destroy

  # Method to check who is online
  def online?
    !last_sign_out_at.present? || last_sign_out_at < 15.minutes.ago
  end
end
