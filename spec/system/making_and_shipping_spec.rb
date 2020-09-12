require 'rails_helper'

RSpec.describe 'making_and_shipping' do
  let!(:admin) { create(:admin) }
  let!(:end_user) { create(:end_user) }
  let!(:genre) { create(:genre) }
  let!(:item1) { create(:item) }
  let!(:item2) { create(:item2) }
  let!(:order) { create(:order) }
  let!(:order_item) { create(:order_item) }
  let!(:order_item2) { create(:order_item2) }
  it "製作〜発送のテスト" do
    #管理者側
    #管理者でログインする
    visit new_admin_session_path
    fill_in 'admin[email]', with: admin.email
    fill_in 'admin[password]', with: admin.password
    find(".btn-primary").click
    expect(page).to have_content '管理者画面'

    #ヘッダから注文履歴一覧へのリンクを押下し、注文履歴一覧画面が表示される
    click_button '注文履歴一覧'
    expect(page).to have_content '注文履歴一覧'

    #前テストでの注文の詳細表示ボタンを押下し、注文詳細画面が表示される
    find("#order_1").click
    expect(page).to have_content '注文履歴詳細'

    #注文ステータスを入金確認にし、製作ステータスが「製作待ち」に更新される
    within '#edit_order_1' do
      select '入金確認', from: 'order[status]'
      click_button '更新'
      expect(page).to have_select('order[status]', selected: '入金確認')
    end
    within '#edit_order_item_1' do
      expect(page).to have_select('order_item[making_status]', selected: '製作待ち')
    end
    within '#edit_order_item_2' do
      expect(page).to have_select('order_item[making_status]', selected: '製作待ち')
    end

    #製作ステータスを１つ「製作中」にすると、注文ステータスが「製作中」に更新される
    within '#edit_order_item_1' do
      select '製作中', from: 'order_item[making_status]'
      click_button '更新'
      expect(page).to have_select('order_item[making_status]', selected: '製作中')
    end
    within '#edit_order_1' do
      expect(page).to have_select('order[status]', selected: '製作中')
    end

    #製作ステータスを全て「制作完了」にすると、注文ステータスが「発送準備中」に更新される
    within '#edit_order_item_1' do
      select '製作完了', from: 'order_item[making_status]'
      click_button '更新'
      expect(page).to have_select('order_item[making_status]', selected: '製作完了')
    end
    within '#edit_order_item_2' do
      select '製作完了', from: 'order_item[making_status]'
      click_button '更新'
      expect(page).to have_select('order_item[making_status]', selected: '製作完了')
    end
    within '#edit_order_1' do
      expect(page).to have_select('order[status]', selected: '発送準備中')
    end

    #注文ステータスを「発送済み」にする
    within '#edit_order_1' do
      select '発送済み', from: 'order[status]'
      click_button '更新'
      expect(page).to have_select('order[status]', selected: '発送済み')
    end

    #ヘッダからログアウトボタンを押下し、管理者ログイン画面に遷移する
    click_button 'ログアウト'
    expect(page).to have_content '管理者ログイン'

    #顧客側
    # メールアドレス・パスワードでログインする
    visit new_end_user_session_path
    fill_in 'end_user[email]', with: 'sample@example.com'
    fill_in 'end_user[password]', with: 'password'
    find(".btn-primary").click
    expect(page).to have_content 'ようこそ、サンプルさん！'
    expect(page).to have_content 'ようこそ、ながのCAKE へ！'

    #ヘッダからマイページに遷移する
    click_button 'マイページ'
    expect(page).to have_content 'マイページ'

    #注文履歴一覧画面に遷移する
    within '.orders' do
      click_link "一覧を見る"
    end
    expect(page).to have_content '注文履歴一覧'

    #注文履歴から先ほど注文した注文の詳細表示ボタンを押下する
    click_link '表示する'
    expect(page).to have_content '注文履歴詳細'

    #注文ステータスが「発送済」になっている
    expect(page).to have_content '発送済'
  end
end