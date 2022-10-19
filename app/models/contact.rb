class Contact < ApplicationRecord
  has_many :notes, as: :notable, dependent: :destroy
  has_many :account_contact_roles, dependent: :destroy
  has_many :accounts,  through: :account_contact_roles

  validates :first_name, presence: true
  validates :last_name, presence: true

  validates :primary_phone, phone: { allow_blank: true }
  validates :secondary_phone, phone: { allow_blank: true }
  validates :email, email: { mode: :strict }, uniqueness: { case_sensitive: false }
end
