require "test_helper"

feature "Homepage works" do


  scenario "The page is online" do
    visit root_path
    page.wont_have_content "FreshStart"
  end
end
