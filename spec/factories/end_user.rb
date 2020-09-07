FactoryBot.define do
  factory :end_user do
    family_name {"サンプル"}
    first_name {"太郎"}
    family_name_kana {"サンプル"}
    first_name_kana {"タロウ"}
    postal_code {"1008111"}
    phone_number {"09000000000"}
    address {"東京都千代田区千代田１−１"}
    email {"sample@example.com"}
    password {"password"}
    is_deleted {false}
  end
end