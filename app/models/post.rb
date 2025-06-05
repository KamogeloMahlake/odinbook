class Post < ApplicationRecord
  validates :user_id, presence: true
  validates :content, presence: false
  validates :images, presence: false

  has_many_attached :images, dependent: :destroy
  belongs_to :user
  has_many :comments, dependent: :destroy
end
