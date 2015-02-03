class Section < ActiveRecord::Base
  validates :name, :presence => true
  validates :description, :presence => true
  def total_posts
    a = self.topics
    c = 0
    a.each do |b|
      c += b.posts.count
    end
    return c
  end

  def last_post
    all_topics = self.topics
    if all_topics.empty?
      return "Empty Section. :("
    else
      latest = all_topics.last.posts.last
      all_topics.each do |topic|
        if topic.created_at > latest.created_at
          latest = topic
        end
      end
      return latest
    end
  end

  has_many :topics
end
