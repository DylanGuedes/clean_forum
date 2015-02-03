class Topic < ActiveRecord::Base
  belongs_to :section
  belongs_to :user
  has_many :posts
  has_many :report_topics

  validates :content, :presence => true, :length => { minimum: 3, maximum: 9999999 }
  validates :title, :presence => true, :length => { minimum: 5, maximum: 50 }
  validates :subtitle, :length => { maximum: 50 }
  validates :user_id, :presence => true
  validates :section_id, :presence => true
end
