class User < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :validatable

  has_many :jti_claims, dependent: :destroy
  has_many :advisor_territories,
           class_name: 'Territory',
           foreign_key: :advisor_id,
           dependent: :nullify,
           inverse_of: :advisor
  has_many :sales_territories,
           class_name: 'Territory',
           foreign_key: :sales_id,
           dependent: :nullify,
           inverse_of: :sales

  enumeration :role
  validates :role, presence: true
  delegate :admin?, :advisor?, :sales?, to: :role
end
