class Topic < ActiveRecord::Base
  belongs_to :section
  has_many :posts
  belongs_to :user
  validates :content_for_posts, :presence => true
  validates :title, :presence => true


  def has_posts?
    if !self.posts.nil?
      true
    else
      false
    end
  end
end
