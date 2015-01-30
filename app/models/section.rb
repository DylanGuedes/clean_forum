class Section < ActiveRecord::Base
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
    latest_post = ""
    if all_topics.last
      all_topics.each do |topic|
        if topic.has_posts?
          posts = topic.posts
          posts.each do |post|
            if !latest_post.blank?
              if latest_post.created_at < post.created_at
                latest_post = post
              end
            else
              latest_post = post
            end
          end

        end
        return latest_post
      end
      return "no posts here! :("
    end
    return "No posts here! :("
  end

  has_many :topics
end
