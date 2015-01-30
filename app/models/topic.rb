class Topic < ActiveRecord::Base
  belongs_to :section
  has_many :posts
  def has_posts?
    if !self.posts.nil?
      true
    else
      false
    end
  end
end
