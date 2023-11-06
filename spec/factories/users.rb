FactoryBot.define do
  factory :user do
    email { "user@example.com" }
    password { "password" }
    admin { false }

    trait :admin do
      admin { true }
    end

  end
end
