class User < ActiveRecord::Base
  has_many :users_posts
  has_many :posts, :through => :users_posts
  has_many :users_random_posts, :dependent => :destroy
  has_many :random_posts, :through => :users_random_posts, :source => :post, :order => '"users_random_posts"."created_at" DESC'
  has_many :likes
  has_many :liked_posts, :through => :likes, :source => :post

  attr_accessible :void_id

  validates :void_id, :uniqueness => true, :presence => true

  def active_random_posts
    random_posts.where('"users_random_posts"."deleted" = ?', false)
  end

  def inactive_random_posts
    random_posts.where('"users_random_posts"."deleted" = ?', true)
  end

  def related_posts
    posts | random_posts
  end

  def to_param
    void_id
  end
end
