require 'rails_helper'

RSpec.describe 'user_registration_and_order' do
  let(:genre) { create(:genre) }
  let(:item1) { create(:item) }
  let(:item2) { create(:item2) }
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
    select '3', from: 'item[quantity]'
    click_button 'カートに入れる'

    #カート画面に遷移し、商品が追加されているか確認
    expect(page).to have_content 'ショッピングカート'
    expect(page).to have_content 'ショートケーキ'
    expect(page).to have_content '1,500'

    #買い物を続けるボタンを押下しトップページへ遷移
    click_button '買い物を続ける'
    expect(page).to have_content 'オススメ商品'

    #別の商品画像を押下し商品詳細画面に移行する
    click_link 'チョコレートケーキ'
    expect(page).to have_content 'チョコレートケーキ'

    #個数を選択しカートに入れるボタンを押下する
    select '3', from: 'item[quantity]'
    click_button 'カートに入れる'

    #カート画面に遷移し、商品が追加されているか確認
    expect(page).to have_content 'ショッピングカート'
    expect(page).to have_content 'ショートケーキ'
    expect(page).to have_content '1,500'
    expect(page).to have_content 'チョコレートケーキ'
    expect(page).to have_content '1,800'
    expect(page).to have_content '3,300'

    #商品の個数を変更し、更新ボタンを押下

    #合計金額が正しく更新される
  end
end