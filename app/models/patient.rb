class Patient < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :psychologist, optional: true
  has_many :appointments, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_one_attached :photo

  validates :address, presence: true
  validates :date_of_birth, presence: true
  validate :date_of_birth_cannot_be_in_the_future
  validates :email, presence: true, uniqueness: true
  validates :full_name, presence: true
  validates :phone_number, presence: true

  # Check if the patient is online (based on online column)
  def online?
    self.online
  end

  def date_of_birth_cannot_be_in_the_future
    if date_of_birth.present? && date_of_birth > Date.today
      errors.add(:date_of_birth, "não pode estar no futuro")
    end
  end

  def age
    return unless date_of_birth

    now = Time.now.utc.to_date
    now.year - date_of_birth.year - ((now.month > date_of_birth.month || (now.month == date_of_birth.month && now.day >= date_of_birth.day)) ? 0 : 1)
  end
end
