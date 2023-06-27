class Review < ApplicationRecord
  belongs_to :list

  validates :comment, presence: true
  validates :rating, presence: true
  validates :rating, length: { maximum: 5 }
end
