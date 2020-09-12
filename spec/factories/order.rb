FactoryBot.define do
  factory :order do
    end_user_id { 1 }
    postal_code { "1008111" }
    address { "東京都千代田区千代田１−１" }
    name { "サンプル太郎" }
    subtotal_price { 3080 }
    postage { 800 }
    payment_method { 1 }
    status { 0 }
  end
end