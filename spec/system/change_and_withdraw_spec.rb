require 'rails_helper'

RSpec.describe 'change_and_withdraw' do
  let!(:admin) { create(:admin) }
  let!(:end_user) { create(:end_user) }
  let!(:genre) { create(:genre) }
  let!(:item1) { create(:item) }
  let!(:item2) { create(:item2) }
  let!(:order) { create(:order) }
  let!(:order_item) { create(:order_item) }
  let!(:order_item2) { create(:order_item2) }
  it "登録情報変更〜退会のテスト" do
    #ECサイト
    #マイページにアクセス
    visit new_end_user_session_path
    fill_in 'end_user[email]', with: 'sample@example.com'
    fill_in 'end_user[password]', with: 'password'
    find(".btn-primary").click
    expect(page).to have_content 'ようこそ、サンプルさん！'
    expect(page).to have_content 'ようこそ、ながのCAKE へ！'
    click_button 'マイページ'
    expect(page).to have_content 'マイページ'

    #会員情報編集ボタンを押下し、会員情報編集画面に遷移する
    click_link '編集する'
    expect(page).to have_content '登録情報編集'

    #全項目を変更し、保存ボタンを押下する
    fill_in 'end_user[family_name]', with: '見本'
    fill_in 'end_user[first_name]', with: '二郎'
    fill_in 'end_user[family_name_kana]', with: 'ミホン'
    fill_in 'end_user[first_name_kana]', with: 'ジロウ'
    fill_in 'end_user[email]', with: 'mihon@example.com'
    fill_in 'end_user[postal_code]', with: '1000014'
    fill_in 'end_user[address]', with: '東京都千代田区永田町２丁目３−１'
    fill_in 'end_user[phone_number]', with: '07000000000'
    click_button '編集内容を保存する'
    expect(page).to have_content 'マイページ'

    #変更した内容が表示される
    expect(page).to have_content '見本二郎'
    expect(page).to have_content 'ミホンジロウ'
    expect(page).to have_content '1000014'
    expect(page).to have_content '東京都千代田区永田町２丁目３−１'
    expect(page).to have_content '07000000000'
    expect(page).to have_content 'mihon@example.com'

    #配送先一覧画面に遷移する
    within '.shipping_addresses' do
      click_link "一覧を見る"
    end
    expect(page).to have_content '配送先登録/一覧'

    #各項目を入力し、登録ボタンを押下
    fill_in 'shipping_address[postal_code]', with: '1008916'
    fill_in 'shipping_address[address]', with: '東京都千代田区霞が関１丁目２−２'
    fill_in 'shipping_address[name]', with: '加藤勝信'
    click_button "登録する"

    #登録した内容が表示されている
    expect(page).to have_content '配送先登録/一覧'
    expect(page).to have_content '1008916'
    expect(page).to have_content '東京都千代田区霞が関１丁目２−２'
    expect(page).to have_content '加藤勝信'

    #ヘッダからトップ画面へのリンクをクリックする
    find("#logo").click
    expect(page).to have_content 'ようこそ、ながのCAKE へ！'

    #商品画像を押下し、詳細画面に遷移する
    click_link 'ショートケーキ'
    expect(page).to have_content 'ショートケーキ'

    #個数を選択しカートに入れるボタンを押下する
    select '1', from: 'cart_item[quantity]'
    click_button 'カートに入れる'

    #カート画面に遷移し、商品が追加されているか確認
    expect(page).to have_content 'ショッピングカート'
    expect(page).to have_content 'ショートケーキ'
    expect(page).to have_content '550'

    #次に進むボタンを押下し、情報入力画面に遷移する
    click_link '情報入力に進む'
    expect(page).to have_content '注文情報入力'

    #先程登録した住所を選択し、注文情報確認画面に遷移する
    choose('order_add_2', visible: false)
    find("option[value='1']").select_option
    click_button '確認画面へ進む'
    expect(page).to have_content '注文情報確認'

    #先程登録した住所が選択されているか確認し、購入ボタンを押下する
    expect(page).to have_content '1008916 東京都千代田区霞が関１丁目２−２ 加藤勝信'
    click_button '購入を確定する'
    expect(page).to have_content 'ご購入ありがとうございました！'

    #ヘッダからトップ画面へのリンクをクリックする
    find("#logo").click
    expect(page).to have_content 'ようこそ、ながのCAKE へ！'

    #商品画像を押下し、詳細画面に遷移する
    click_link 'チョコレートケーキ'
    expect(page).to have_content 'チョコレートケーキ'

    #個数を選択しカートに入れるボタンを押下する
    select '2', from: 'cart_item[quantity]'
    click_button 'カートに入れる'

    #カート画面に遷移し、商品が追加されているか確認
    expect(page).to have_content 'ショッピングカート'
    expect(page).to have_content 'チョコレートケーキ'
    expect(page).to have_content '1,320'

    #次に進むボタンを押下し、情報入力画面に遷移する
    click_link '情報入力に進む'
    expect(page).to have_content '注文情報入力'

    #新規で住所を入力し、注文情報確認画面に遷移する
    choose('order_add_3', visible: false)
    fill_in 'order[new_add][postal_code]', with: '1008901'
    fill_in 'order[new_add][address]', with: '東京都千代田区霞が関1-3-1'
    fill_in 'order[new_add][name]', with: '梶山弘志'
    click_button '確認画面へ進む'
    expect(page).to have_content '注文情報確認'

    #新規で登録した配送先が選択されているか確認し、購入ボタンを押下する
    expect(page).to have_content '1008901 東京都千代田区霞が関1-3-1 梶山弘志'
    click_button '購入を確定する'
    expect(page).to have_content 'ご購入ありがとうございました！'

    #ヘッダのマイページへのリンクを押下する
    click_button 'マイページ'
    expect(page).to have_content 'マイページ'

    #配送先一覧画面に遷移する
    within '.shipping_addresses' do
      click_link "一覧を見る"
    end
    expect(page).to have_content '配送先登録/一覧'

    #先程購入時に登録した住所が表示されている
    expect(page).to have_content '1008901'
    expect(page).to have_content '東京都千代田区霞が関1-3-1'
    expect(page).to have_content '梶山弘志'

    #マイページに戻る
    click_button 'マイページ'
    expect(page).to have_content 'マイページ'

    #会員情報編集画面へのリンクを押下する
    click_link '編集する'
    expect(page).to have_content '登録情報編集'

    #退会ボタンを押下する
    click_link '退会する'
    expect(page).to have_content '本当に退会しますか？'

    #「退会する」を押下し、トップページへ遷移する
    click_link '退会する'
    expect(page).to have_content 'ようこそ、ながのCAKE へ！'
    expect(page).to have_button '新規登録'

    #ヘッダからログイン画面に遷移する
    click_button 'ログイン'
    expect(page).to have_content '会員の方はこちらからログイン'

    #退会したアカウントでログインを実施し、ログインが不可であることを確認
    fill_in 'end_user[email]', with: 'mihon@example.com'
    fill_in 'end_user[password]', with: 'password'
    find(".btn-primary").click
    expect(page).to have_content 'Your account is not activated yet.'


    #管理者側
    #ログインする
    visit new_admin_session_path
    fill_in 'admin[email]', with: admin.email
    fill_in 'admin[password]', with: admin.password
    find(".btn-primary").click
    expect(page).to have_content '管理者画面'

    #ヘッダから会員一覧画面へ遷移する
    click_button '会員一覧'
    expect(page).to have_content '会員一覧'

    #先程退会したユーザーが「退会済み」になっている
    expect(page).to have_content '退会済み'

    #会員情報詳細画面に遷移する
    click_link '見本二郎'
    expect(page).to have_content '見本二郎さんの会員詳細'
    expect(page).to have_content '〒1000014'
    expect(page).to have_content '東京都千代田区永田町２丁目３−１'
    expect(page).to have_content '見本二郎'
    expect(page).to have_content 'ミホンジロウ'

    #ヘッダからログアウトボタンを押下し、管理者ログイン画面に遷移する
    click_button 'ログアウト'
    expect(page).to have_content '管理者ログイン'
  end
end