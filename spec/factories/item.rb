FactoryBot.define do
  factory :item do
    genre_id { 1 }
    name { "ショートケーキ" }
    introduction { "商品の説明です" }
    price { 500 }
    image_id { nil }
    sales_status { true }
  end
  factory :item2, class: Item do
    genre_id { 1 }
    name { "チョコレートケーキ" }
    introduction { "商品の説明です" }
    price { 600 }
    image_id { nil }
    sales_status { true }
  end
end