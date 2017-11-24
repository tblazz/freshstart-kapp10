# == Schema Information
#
# Table name: results
#
#  id                   :uuid             not null, primary key
#  race_id              :uuid
#  phone                :string
#  mail                 :string
#  rank                 :integer
#  name                 :string
#  country              :string
#  bib                  :string
#  categ_rank           :integer
#  categ                :string
#  sex_rank             :integer
#  sex                  :string
#  time                 :string
#  speed                :string
#  message              :string
#  race_detail          :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  uploaded_at          :datetime
#  diploma_generated_at :datetime
#  email_sent_at        :datetime
#  sms_sent_at          :datetime
#  diploma_url          :string
#

class Result < ActiveRecord::Base
  belongs_to :edition

  def sent_message
    sms.message
  end

  def rank_total
    rank == 1 ? I18n.t('first_suffix') : rank == 2 ? I18n.t('second_suffix') : I18n.t('third_suffix')
  end

  def sms
    @sms ||=  SMS.new(
      name: first_name,
      time: time,
      edition_name_mail: edition.email_name,
      rank: "#{rank}#{rank_total}",
      template: edition.sms_message,
      edition_detail: race_detail,
      results_url: edition.results_url,
      phone_number: phone,
      image_path: diploma_url,
      campaign: "#{edition.event.name.parameterize}-#{edition.date}"
    )
  end

  # def first_name
  #   @first_name ||= (first_names.count > 0) ? first_names[0] : name
  # end
  #
  # def first_names
  #   @first_names ||= name.strip.split(/\s+/)
  # end

  def photo
    photo = Photo.where(bib: bib, edition_id: edition_id)
    return :no_photo if photo.empty?
    photo.first
  end

	def self.search(search)
	  if search
			where "lower(name) LIKE ? OR bib LIKE ?", "%#{search.downcase}%", "%#{search}%"
	  else
	    where nil
	  end
	end
end
