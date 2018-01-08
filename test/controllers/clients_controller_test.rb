require "test_helper"

describe ClientsController do
  it "should get new" do
    get clients_new_url
    value(response).must_be :success?
  end

  it "should get show" do
    get clients_show_url
    value(response).must_be :success?
  end

  it "should get index" do
    get clients_index_url
    value(response).must_be :success?
  end

end
