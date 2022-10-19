class AccountContactRole < ApplicationRecord
  belongs_to :account
  belongs_to :contact

  validates :role, presence: true
  enumeration :role, class_name: ContactRole
end
