require 'rails_helper'


RSpec.describe "ProtectedPages" do

  before do
    user = User.new(email:'c@cfmeyers.com', password: '12345678')
    user.skip_confirmation!
    user.save!
  end

  it "is impossible to access protected_pages without being logged in" do
    visit '/protected_pages/download_csv'
    expect(page).to have_content("You need to sign in or sign up before continuing.")
  end

  describe "download_csv page when properly authenticated" do

    before do
      visit new_user_session_path
      fill_in 'Email', with: 'c@cfmeyers.com'
      fill_in 'Password', with: '12345678'
      click_button 'Log in'
    end

    it "has a title that indicates full access" do
      visit '/protected_pages/download_csv'
      expect(page).to have_content("Docket Donkey")
    end


  end

end
