FactoryBot.define do
  factory :item do
    genre_id { 1 }
    name { "ショートケーキ" }
    introduction { "商品の説明です" }
    price { 500 }
    image_id { nil }
    sales_status { true }
  end
end