class ShippingAddress < ApplicationRecord
  validates :postal_code, presence: true, length: { is: 7 }
  validates :address, presence: true
  validates :name, presence: true

  belongs_to :end_user
end
