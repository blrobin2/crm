FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { '123456' }
    first_name { 'John' }
    last_name { 'Doe' }
    role { UserRole.advisor }

    after :create do |user|
      create :jti_claim, user: user
    end
  end

  factory :admin, parent: :user do
    role { UserRole.admin }
  end

  factory :advisor, parent: :user do
    role { UserRole.advisor }

    trait :with_territories do
      after :create do |user|
        create_list(:territory, 3, advisor: user)
      end
    end
  end

  factory :sales, parent: :user do
    role { UserRole.sales }

    trait :with_territories do
      after :create do |user|
        create_list(:territory, 3, sales: user)
      end
    end
  end
end
