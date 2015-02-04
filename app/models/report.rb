class Report < ActiveRecord::Base
  belongs_to :user

  validates :user_id, :presence => true
  validates :description, :presence => true, :length => { minimum: 15, maximum: 500 }
end
