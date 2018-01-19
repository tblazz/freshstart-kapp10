require "test_helper"

describe ChallengesController do
  it "should get new" do
    get challenges_new_url
    value(response).must_be :success?
  end

  it "should get show" do
    get challenges_show_url
    value(response).must_be :success?
  end

  it "should get index" do
    get challenges_index_url
    value(response).must_be :success?
  end

end
