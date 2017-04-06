class Race < ActiveRecord::Base
  has_attached_file :raw_results
  has_attached_file :background_image, styles: { medium: "300x300", standard: "1024x1024" }
  has_many :results, dependent: :destroy
  validates_attachment_content_type :raw_results, :content_type => ["text/plain", "text/csv"]
  validates_attachment_content_type :background_image, content_type: /\Aimage\/.*\z/

  def runners_count
    @runners_count ||= results.count
  end

  def races_count
    @races_count ||= results.select(:race_detail).uniq.count
  end

  def races
    @races ||= results.select(:race_detail).uniq.pluck(:race_detail)
  end
end
