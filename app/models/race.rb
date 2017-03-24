class Race < ActiveRecord::Base
  has_attached_file :raw_results
  has_many :results
  validates_attachment_content_type :raw_results, :content_type => ["text/plain", "text/csv"]
end
