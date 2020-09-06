# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Genre.create!(name: "ケーキ", is_active: true)
Genre.create!(name: "プリン・ゼリー", is_active: true)
Genre.create!(name: "クッキー・焼き菓子", is_active: true)
Genre.create!(name: "キャンディ", is_active: true)

Item.create!(genre_id: 1, name: "洋梨のチーズタルト", introduction: "編集中",
            price: 1200,sales_status: true)
Item.create!(genre_id: 1, name: "ザッハトルテ", introduction: "編集中",
            price: 2900,sales_status: true)
Item.create!(genre_id: 1, name: "いちごのショートケーキ", introduction: "編集中",
            price: 500,sales_status: true)
Item.create!(genre_id: 2, name: "卵たっぷり濃厚プリン", introduction: "編集中",
            price: 500,sales_status: true)
Item.create!(genre_id: 3, name: "紅茶のクッキー", introduction: "編集中",
            price: 800,sales_status: true)
Item.create!(genre_id: 1, name: "フルーツタルト", introduction: "編集中",
            price: 2900,sales_status: true)
Item.create!(genre_id: 2, name: "大きな桃のゼリー", introduction: "編集中",
            price: 480,sales_status: true)
Item.create!(genre_id: 3, name: "マカロンセット（8個)", introduction: "編集中",
            price: 1200,sales_status: true)
Item.create!(genre_id: 3, name: "マカロンセット（16個)", introduction: "編集中",
            price: 2000,sales_status: true)
Item.create!(genre_id: 1, name: "バナナケーキ", introduction: "編集中",
            price: 980,sales_status: true)

