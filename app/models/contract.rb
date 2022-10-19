class Contract < ApplicationRecord
  belongs_to :account
  belongs_to :company_signed_by, class_name: 'User'
  belongs_to :customer_signed_by, class_name: 'Contact'
end
