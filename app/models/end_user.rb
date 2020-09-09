class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders


  validates :family_name, :first_name, :postal_code, :address, :phone_number, presence: true
  # 全角カナ入力のバリデーション
  validates :family_name_kana, :first_name_kana, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/}
  
  has_many :cart_items
  has_many :shipping_addresses

  def active_for_authentication?
    super && (self.is_deleted == false)
    flash[:notice] = "退会手続きが完了いたしました。"
  end

end
