class Post < ApplicationRecord
  has_rich_text :content

  belongs_to :customer

  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :post_tags
  has_many :tags, through: :post_tags

  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  scope :star_count, -> {order(star: :desc)}

  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end

  def save_tags(tags)
  current_tags = self.tags.pluck(:name) # 現在のタグ名を取得
  old_tags = current_tags - tags # 削除されるべき古いタグ
  new_tags = tags - current_tags # 新しく追加されるタグ

  # 古いタグを削除
  old_tags.each do |old_name|
    self.tags.delete Tag.find_by(name: old_name)
  end

  # 新しいタグを追加
  new_tags.each do |new_name|
    tag = Tag.find_or_create_by(name: new_name)
    # PostTag 結合テーブルを直接確認し、重複がないことを確認してから追加
    unless PostTag.exists?(post_id: self.id, tag_id: tag.id)
      self.tags << tag
    end
  end
end

  def self.search_for(content, method)
    if method == 'perfect'
      Post.where(title: content)
    elsif method == 'forward'
      Post.where('title LIKE ?', content + '%')
    elsif method == 'backward'
      Post.where('title LIKE ?', '%' + content)
    else
      Post.where('title LIKE ?', '%' + content + '%')
    end
  end

  def active_for_authentication?
    super && (is_deleted == false)
  end

  validates :title, presence: true
  validates :content, presence: true
 
end
