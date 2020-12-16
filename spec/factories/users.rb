FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "email#{"+#{n}"}@example.com" }
    password { '123456' }
    first_name { 'John' }
    last_name { 'Doe' }
    role { Role.advisor }

    after :create do |user|
      create :jti_claim, user: user
    end
  end

  factory :admin, parent: :user do
    role { Role.admin }
  end

  factory :advisor, parent: :user do
    role { Role.advisor }
  end

  factory :sales, parent: :user do
    role { Role.sales }
  end
end
