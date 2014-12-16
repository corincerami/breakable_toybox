require 'rails_helper'

feature "User submits a link" do
  it "posts a valid link" do
    visit '/toys/new'
    fill_in "Title", with: "My Breakable Toy"
    fill_in "Url", with: "http://www.google.com"
    click_on "Submit Link"

    expect(page).to have_content("My Breakable Toy")
    expect(page).to have_content("http://www.google.com")
  end

  it "submits a blank form" do
    visit '/toys/new'
    click_on "Submit Link"

    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Url can't be blank")
  end
end
