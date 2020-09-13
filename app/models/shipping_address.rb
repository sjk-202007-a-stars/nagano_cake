class ShippingAddress < ApplicationRecord
  validates :postal_code, presence: true, length: { is: 7 }
  validates :address, presence: true
  validates :name, presence: true

  belongs_to :end_user

  def postal_code_address_name
    self.postal_code + "　" + self.address + "　" + self.name
  end
end
