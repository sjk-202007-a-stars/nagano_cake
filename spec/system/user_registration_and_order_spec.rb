require 'rails_helper'

RSpec.describe 'user_registration_and_order' do
  let!(:genre) { create(:genre) }
  let!(:item1) { create(:item) }
  let!(:item2) { create(:item2) }
  it "ユーザー新規登録〜注文のテスト" do
    visit root_path

    #新規登録画面へのリンクを押す
    click_button '新規登録'
    expect(page).to have_content '新規会員登録'

    #必要事項を記入して登録ボタンを押下する
    fill_in 'end_user[family_name]', with: 'サンプル'
    fill_in 'end_user[first_name]', with: '太郎'
    fill_in 'end_user[family_name_kana]', with: 'サンプル'
    fill_in 'end_user[first_name_kana]', with: 'タロウ'
    fill_in 'end_user[email]', with: 'sample@example.com'
    fill_in 'end_user[postal_code]', with: '1008111'
    fill_in 'end_user[address]', with: '東京都千代田区千代田１−１'
    fill_in 'end_user[phone_number]', with: '09000000000'
    fill_in 'end_user[password]', with: 'password'
    fill_in 'end_user[password_confirmation]', with: 'password'
    find(".btn-success").click

    #ヘッダがログイン後の表示に変わっているか確認
    expect(page).to have_content 'ようこそ、サンプルさん！'

    #トップ画面の商品画像から商品詳細画面に移行する
    click_link 'ショートケーキ'
    expect(page).to have_content 'ショートケーキ'

    #個数を選択しカートに入れるボタンを押下する
    select '3', from: 'cart_item[quantity]'
    click_button 'カートに入れる'

    #カート画面に遷移し、商品が追加されているか確認
    expect(page).to have_content 'ショッピングカート'
    expect(page).to have_content 'ショートケーキ'
    expect(page).to have_content '1,650'

    #買い物を続けるボタンを押下しトップページへ遷移
    click_link '買い物を続ける'
    expect(page).to have_content 'オススメ商品'

    #別の商品画像を押下し商品詳細画面に移行する
    click_link 'チョコレートケーキ'
    expect(page).to have_content 'チョコレートケーキ'

    #個数を選択しカートに入れるボタンを押下する
    select '3', from: 'cart_item[quantity]'
    click_button 'カートに入れる'

    #カート画面に遷移し、商品が追加されているか確認
    expect(page).to have_content 'ショッピングカート'
    expect(page).to have_content 'ショートケーキ'
    expect(page).to have_content '1,650'
    expect(page).to have_content 'チョコレートケーキ'
    expect(page).to have_content '1,980'
    expect(page).to have_content '3,630'

    #商品の個数を変更し、更新ボタンを押下
    within '#edit_cart_item_1' do
      select '2', from: 'cart_item[quantity]'
      click_button '変更'
    end

    #合計金額が正しく更新される
    expect(page).to have_content 'ショッピングカート'
    expect(page).to have_content 'ショートケーキ'
    expect(page).to have_content '1,100'
    expect(page).to have_content 'チョコレートケーキ'
    expect(page).to have_content '1,980'
    expect(page).to have_content '3,080'

    #次に進むボタンを押下し、情報入力画面に遷移する
    click_link '情報入力に進む'
    expect(page).to have_content '注文情報入力'

    #支払い方法を選択する
    choose('order_payment_method_1', visible: false)

    #登録済みの自分の住所を選択する
    choose 'ご自身の住所'

    #次に進むボタンを押下し、注文確認画面に遷移する
    click_button '確認画面へ進む'
    expect(page).to have_content '注文情報確認'

    #選択した商品、合計金額、配送方法などが表示されている
    expect(page).to have_content 'ショートケーキ'
    expect(page).to have_content 'チョコレートケーキ'
    expect(page).to have_content '3,080'
    expect(page).to have_content '3,880'
    expect(page).to have_content '銀行振込'
    expect(page).to have_content '東京都千代田区千代田１−１'

    #確定ボタンを押下し、サンクスページに遷移する
    click_button '購入を確定する'
    expect(page).to have_content 'ご購入ありがとうございました！'

    #ヘッダーのマイページのリンクを押下し、マイページに遷移する
    click_button 'マイページ'
    expect(page).to have_content 'マイページ'

    #注文履歴一覧へのリンクを押下し、注文履歴一覧画面が表示される
    within '.orders' do
      click_link "一覧を見る"
    end
    expect(page).to have_content '注文履歴一覧'

    #先程の注文の詳細表示ボタンを押下し、注文詳細画面が表示される
    click_link '表示する'
    expect(page).to have_content '注文履歴詳細'

    #注文内容が正しく表示されている
    expect(page).to have_content 'ショートケーキ'
    expect(page).to have_content 'チョコレートケーキ'
    expect(page).to have_content '3,080'
    expect(page).to have_content '3,880'
    expect(page).to have_content '銀行振込'
    expect(page).to have_content '東京都千代田区千代田１−１'

    #ステータスが入金待ちになっている
    expect(page).to have_content '入金待ち'

  end
end
