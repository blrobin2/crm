class Account < ApplicationRecord
  belongs_to :territory
  belongs_to :parent_account, class_name: 'Account', optional: true

  has_many :notes, as: :notable, dependent: :destroy
  has_many :account_contact_roles, dependent: :destroy
  has_many :contacts, through: :account_contact_roles do
    def owner
      find_by!(account_contact_roles: { role: :owner })
    end
  end

  validates :name, presence: true

  delegate :sales_person, :advisor, to: :territory
  delegate :owner, to: :contacts
end
