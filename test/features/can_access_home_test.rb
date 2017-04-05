require "test_helper"

feature "CanAccessHome" do
  scenario "The page is online" do
    visit root_path
    page.must_have_content "Hello World"
    page.wont_have_content "Goodbye All!"
  end
end
