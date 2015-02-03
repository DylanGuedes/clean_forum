class Post < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user
  has_many :report_posts

  validates :content, :presence => true, :length => { :minimum => 2 }
  validates :topic_id, :presence => true
  validates :user_id, :presence => true  
end
