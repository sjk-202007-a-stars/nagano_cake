class Genre < ApplicationRecord
  validates :name, presence: true, uniqueness: true,
                    length: {maximum: 20}
  validates :is_active, inclusion: {in: [true, false]}
end
