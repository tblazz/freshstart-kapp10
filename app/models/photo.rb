# == Schema Information
#
# Table name: photos
#
#  id                 :uuid             not null, primary key
#  race_id            :uuid
#  suggested_bibs     :string
#  bib                :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#

class Photo < ApplicationRecord
  belongs_to :edition
  has_attached_file :image
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  validates :image_file_name, uniqueness: { scope: :edition_id }

  def runner
    return @runner unless @runner.nil?
    return :not_paired if bib.blank?
    runner = edition.results.where(bib: bib)
    return :invalid_bib if runner.empty?
    runner.first
  end

  def runner_alert
    return "<p id='#{id}_runner'></p>".html_safe if runner == :not_paired
    return "<p id='#{id}_runner' class='alert alert-danger'>Mauvais numéro de dossard</p>".html_safe if runner == :invalid_bib
    "<p id='#{id}_runner' class='alert alert-success'>#{runner.name} (#{runner.bib})</p>".html_safe
  end

end
