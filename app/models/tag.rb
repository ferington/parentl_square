class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destroy
  has_many :posts, through: :post_tags

  validates :name, presence:true, length:{maximum:50}

  # アクティブな投稿に紐づいくタグのみを返すスコープ
  def self.active
    Tag.joins(:posts).where(posts: {is_deleted: false}).distinct
  end

end
