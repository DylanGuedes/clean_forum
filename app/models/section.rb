class Section < ActiveRecord::Base
  validates :name, :presence => true
  validates :description, :presence => true

  def total_posts
    total = 0
    self.topics.each do |post_count|
      total += post_count.posts.count
    end
    return total
  end

  def last_post
    if self.topics.empty?
      return "Empty Section. :("
    else
      latest = self.topics.last.posts.last
      self.topics.each do |topic|
        if topic.posts.last.created_at > latest.created_at
          latest = topic.posts.last
        end
      end
      return latest
    end
  end

  has_many :topics
end
