require 'rails_helper'

feature 'User deletes a toy' do
  it "removes the toy from the index" do
    user = FactoryGirl.create(:user)
    toy = Toy.create(title: "A toy", url: 'bing.com', user_id: user.id, creator: "Chris Cerami")
    visit toy_path(toy)
    click_on "Sign in"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_on "Log in"
    visit toy_path(toy)
    click_on "Delete app"
    expect(page).not_to have_content("A toy by Chris Cerami")
  end
end
