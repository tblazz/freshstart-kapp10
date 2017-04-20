# == Schema Information
#
# Table name: races
#
#  id                            :uuid             not null, primary key
#  name                          :string
#  email_sender                  :string
#  email_name                    :string
#  date                          :date
#  hashtag                       :string
#  results_url                   :string
#  sms_message                   :string
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
#  template                      :string
#  widget_generated_at           :datetime
#  user_id                       :integer
#

require 'test_helper'

class RaceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
