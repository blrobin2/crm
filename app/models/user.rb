class User < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :validatable

  has_many :jti_claims, dependent: :destroy

  enumeration :role

  validates :role, presence: true
  ALPHA_ONLY = /\A[a-zA-Z\-]+\z/.freeze
  validates :first_name,
            format: { with: ALPHA_ONLY,
                      message: 'only allows letters',
                      allow_nil: true }
  validates :last_name,
            format: { with: ALPHA_ONLY,
                      message: 'only allows letters',
                      allow_nil: true }
end
