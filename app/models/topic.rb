class Topic < ActiveRecord::Base
  belongs_to :section
  belongs_to :user
  has_many :posts
  has_many :report_topics

  validates :content, :presence => true
  validates :title, :presence => true  
end
