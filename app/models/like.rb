class Like < ApplicationRecord
  belongs_to :user
  belongs_to :article

  validates :user_id, presence: true
  validates :article_id, presence: true
  validates_uniqueness_of :article_id, scope: :user_id 
end
