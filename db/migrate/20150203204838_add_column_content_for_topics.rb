class AddColumnContentForTopics < ActiveRecord::Migration
  def change
    add_column :topics, :content, :text
    remove_column :posts, :pending
    remove_column :posts, :report_description
    remove_column :topics, :content_for_posts
  end
end
