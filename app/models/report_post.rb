class ReportPost < Report
  belongs_to :post

  validates :description, :presence => true, :length => { minimum: 15, maximum: 500 }
  validates :post_id, :presence => true  
end

