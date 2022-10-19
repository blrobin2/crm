class AccountSerializer < BaseSerializer
  set_type :accounts

  attribute :name

  belongs_to :territory
end
