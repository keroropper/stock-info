class Article < ApplicationRecord
  has_many :article_tag_relations
  has_many :tags, through: :article_tag_relations
  has_many_attached :images
  belongs_to :user
  has_many :likes

  with_options presence: true do
    validates :title, length: { maximum: 40 }
    validates :content, length: { maximum: 1000 }
  end

  def save_tags(tag_list)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - tag_list
    new_tags = tag_list - current_tags
  
      # Destroy old taggings:
      old_tags.each do |old_name|
        self.tags.delete Tag.find_by(name:old_name)
      end
  
      # Create new taggings:
      new_tags.each do |new_name|
        tag_list = Tag.find_or_create_by(name:new_name)
        self.tags << tag_list
      end
  end

  def like_user(user_id)
    likes.find_by(user_id: user_id)
  end
end
