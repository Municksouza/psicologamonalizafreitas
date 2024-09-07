class Psychologist < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :patients, dependent: :destroy
  has_many :appointments, dependent: :destroy
  has_many :messages, as: :sendable, dependent: :destroy
  has_one_attached :photo

  validates :full_name, :email, :phone_number, presence: true
  # Check if the psychologist is online (based on online column)
  def online?
    self.online
  end
end
