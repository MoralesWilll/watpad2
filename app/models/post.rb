class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :name, presence: true
  validates :tags, presence: true

  scope :search_by_description, ->(keyword) { where("description LIKE ?", "%#{keyword}%") }
  scope :search_by_tag, ->(keyword) { where("tags LIKE ?", "%#{keyword}%") }

  # Callback to clean up description before saving
  before_save :normalize_description

  private

  def normalize_description
    self.description = description.strip.squeeze(" ").downcase
  end
end
