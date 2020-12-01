FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "email#{"+#{n}"}@example.com" }
    password { '123456' }
    first_name { 'John' }
    last_name { 'Doe' }

    after :create do |user|
      create :jti_claim, user: user
    end
  end
end
