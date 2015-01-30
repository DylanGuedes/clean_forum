class AddContentForPostsToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :content_for_posts, :string
  end
end
