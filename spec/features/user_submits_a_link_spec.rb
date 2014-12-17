require 'rails_helper'


feature "User submits a link" do
  it "posts a valid link" do
    user = FactoryGirl.create(:user)

    visit '/users/sign_in'
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_on "Log in"
    visit '/toys/new'
    fill_in "Title", with: "My Breakable Toy"
    fill_in "Url", with: "http://www.google.com"
    fill_in "Creator", with: "Darkwing Duck"
    click_on "Submit Link"

    expect(page).to have_content("My Breakable Toy by Darkwing Duck")
    expect(page).to have_content("App submitted successfully")
  end

  it "submits a blank form" do
    user = FactoryGirl.create(:user)

    visit '/users/sign_in'
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_on "Log in"
    visit '/toys/new'
    click_on "Submit Link"

    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Url can't be blank")
  end
end
