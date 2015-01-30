class Section < ActiveRecord::Base
  def total_posts
    a = self.topics
    c = 0
    a.each do |b|
      c += b.posts.count
    end
    return c
  end
  has_many :topics
end
