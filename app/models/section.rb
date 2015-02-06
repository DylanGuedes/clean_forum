class Section < ActiveRecord::Base
  belongs_to :user
  has_many :topics

  validates :name, :presence => true, :length => { minimum: 4, maximum: 50 }
  validates :description, :presence => true, :length => { minimum: 10, maximum: 50}
  validates :user_id, :presence => true

  def total_posts
    total = 0
    self.topics.each do |post_count|
      total += post_count.posts.count
    end
    return total
  end

  def has_posts?
    not self.topics.empty?
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

  
end
