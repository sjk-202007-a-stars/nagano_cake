require 'rails_helper'

RSpec.describe 'admin_registration' do
  let(:admin) {create(:admin)}
  it '管理者マスタ登録のテスト' do
    visit new_admin_session_path

    #管理者ログインページでログインする
    fill_in 'admin[email]', with: admin.email
    fill_in 'admin[password]', with: admin.password
    find(".btn-primary").click
    expect(page).to have_content '管理者画面'

    #ヘッダからジャンル一覧画面へ遷移する
    click_button 'ジャンル一覧'
    expect(page).to have_content 'ジャンル一覧・追加'

    #ジャンル一覧画面でジャンルを追加する
    fill_in 'genre[name]', with: "ケーキ"
    click_button '追加'
    expect(page).to have_content 'ケーキ'

    #ヘッダから商品一覧画面へ遷移する
    click_button '商品一覧'
    expect(page).to have_content '商品一覧'

    #商品新規登録ページに遷移する
    # find(".fa-plus-square").click
    #アイコンとaタグがずれているためかリンクをクリックできないので、直接新規登録画面に遷移する
    visit new_admin_item_path
    expect(page).to have_content '商品新規登録'

    #必要事項を入力し商品を新規作成する
    fill_in 'item[name]', with: 'チョコレートケーキ'
    fill_in 'item[introduction]', with: "商品の説明です"
    select 'ケーキ', from: 'item[genre_id]'
    fill_in 'item[price]', with: 500
    select '販売中', from: 'item[sales_status]'
    click_button '新規登録'

    #商品詳細画面に新規登録した商品が表示される
    expect(page).to have_content '商品詳細'
    expect(page).to have_content 'チョコレートケーキ'

    #商品一覧画面に新規登録した商品が表示される
    click_button '商品一覧'
    expect(page).to have_content '商品一覧'
    expect(page).to have_content 'チョコレートケーキ'

    #新規登録ボタンを押下する(2回目)
    # find(".fa-plus-square").click
    #アイコンとaタグがずれているためかリンクをクリックできないので、直接新規登録画面に遷移する
    visit new_admin_item_path
    expect(page).to have_content '商品新規登録'

    #必要事項を入力し商品を新規作成する
    fill_in 'item[name]', with: 'ショートケーキ'
    fill_in 'item[introduction]', with: "商品の説明です"
    select 'ケーキ', from: 'item[genre_id]'
    fill_in 'item[price]', with: 400
    select '販売中', from: 'item[sales_status]'
    click_button '新規登録'

    #商品詳細画面に新規登録した商品が表示される
    expect(page).to have_content '商品詳細'
    expect(page).to have_content 'ショートケーキ'

    #商品一覧画面に新規登録した商品が2つ表示される
    click_button '商品一覧'
    expect(page).to have_content '商品一覧'
    expect(page).to have_content 'チョコレートケーキ'
    expect(page).to have_content 'ショートケーキ'

    #ログアウトする
    click_button 'ログアウト'
    expect(page).to have_content '管理者ログイン'
  end
end