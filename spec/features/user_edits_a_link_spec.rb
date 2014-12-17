require 'rails_helper'

feature "User edits a submitted link" do
  it "changes the URL and title" do
    user = FactoryGirl.create(:user)
    toy = Toy.create(title: "A toy", url: 'bing.com', user_id: user.id, creator: "Chris Cerami")
    visit toy_path(toy)
    click_on "Sign in"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_on "Log in"
    visit toy_path(toy)
    click_on "Edit app"
    fill_in "Title", with: "New name"
    fill_in "Url", with: "google.com"
    fill_in "Creator", with: "Darkwing Duck"
    click_on "Submit"
    expect(page).to have_content("New name")
    expect(page).to have_content("Darkwing Duck")
    expect(page).not_to have_content('A toy')
    expect(page).not_to have_content("Chris Cerami")
    expect(page).to have_content('App edited successfully')
  end

  it "submits a blank form" do
    user = FactoryGirl.create(:user)
    toy = Toy.create(title: "A toy", url: 'bing.com', user_id: user.id, creator: "Chris Cerami")
    visit toy_path(toy)
    click_on "Sign in"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_on "Log in"
    visit toy_path(toy)
    click_on "Edit app"
    fill_in "Title", with: ""
    fill_in "Url", with: ""
    fill_in "Creator", with: ""
    click_on "Submit"

    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Url can't be blank")
  end
end
