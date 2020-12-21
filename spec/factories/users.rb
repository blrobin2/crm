FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
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

    trait :with_territories do
      after :create do |user|
        create_list(:territory, 3, advisor: user)
      end
    end
  end

  factory :sales, parent: :user do
    role { Role.sales }

    trait :with_territories do
      after :create do |user|
        create_list(:territory, 3, sales: user)
      end
    end
  end
end
