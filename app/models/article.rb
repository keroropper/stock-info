class Article < ApplicationRecord
  has_many :article_tag_relations
  has_many :tags, through: :article_tag_relations
  has_many_attached :images
  belongs_to :user

  with_options presence: true do
    validates :title, length: { maximum: 40 }
    validates :content, length: { maximum: 1000 }
  end
end
