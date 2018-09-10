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
#  edition_id         :integer
#  direct_image_url   :string           not null
#  processed          :boolean          default(FALSE)
#

require "test_helper"

describe Photo do
  let(:photo) { Photo.new }

  it "must be valid" do
    value(photo).must_be :valid?
  end
end
