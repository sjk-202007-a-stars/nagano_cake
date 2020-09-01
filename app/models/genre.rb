class Genre < ApplicationRecord
  validates :name, presence: true, length: {maximum: 20}
  validates :is_active, presence: true
end
