# == Schema Information
#
# Table name: editions
#
#  id                            :integer          not null, primary key
#  date                          :date
#  description                   :string
#  event_id                      :integer
#  email_sender                  :string
#  email_name                    :string
#  hashtag                       :string
#  results_url                   :string
#  sms_message                   :string
#  template                      :string
#  widget_generated_at           :datetime
#  photos_widget_generated_at    :datetime
#  external_link                 :string
#  external_link_button          :string
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#  raw_results_file_name         :string
#  raw_results_content_type      :string
#  raw_results_file_size         :integer
#  raw_results_updated_at        :datetime
#  background_image_file_name    :string
#  background_image_content_type :string
#  background_image_file_size    :integer
#  background_image_updated_at   :datetime
#

require 'rails_helper'

RSpec.describe Edition, type: :model do
  it { should belong_to(:event) }
  it { should validate_presence_of(:date) }
  it { should validate_presence_of(:description) }
end
