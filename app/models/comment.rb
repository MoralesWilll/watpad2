class Comment < ApplicationRecord
  belongs_to :post

  validates :content, presence: true
  validates :rating, presence: true, numericality: { only_integer: true, in: 1..5 }
end
