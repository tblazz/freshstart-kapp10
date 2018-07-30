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
#  edition_id           :integer
#  runner_id            :integer
#  points               :integer
#  first_name           :string
#  last_name            :string
#  dob                  :datetime
#  processed            :boolean          default(FALSE)
#  diploma_file_name    :string
#  diploma_content_type :string
#  diploma_file_size    :integer
#  diploma_updated_at   :datetime
#  purchased_at         :datetime
#  stripe_charge_id     :string
#

require 'test_helper'

class ResultTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
