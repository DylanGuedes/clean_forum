class ReportTopic < Report
  belongs_to :topic
  
  validates :description, :presence => true, :length => { minimum: 15, maximum: 500 }
  validates :topic_id, :presence => true  
end