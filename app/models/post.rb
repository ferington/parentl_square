class Post < ApplicationRecord
  has_rich_text :content

  belongs_to :customer
  
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :favorites, dependent: :destroy
  
  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  scope :star_count, -> {order(star: :desc)}
  
  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end
  
  def save_tags(tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - tags
    new_tags = tags - current_tags

    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name: old_name )
    end

    new_tags.each do |new_name|
      tag = Tag.find_or_create_by(name: new_name )
      self.tags << tag
    end
    
  end
  
  validates :title, presence: true
  validates :content, presence: true
  
end
