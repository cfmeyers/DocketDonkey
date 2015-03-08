require 'rails_helper'


RSpec.describe "ProtectedPages" do

  describe "download_csv page" do

    it "has a title that indicates full access" do
      visit new_user_session_path
      fill_in 'Email', with: 'c@cfmeyers.com'
      fill_in 'Password', with: '12345678'
      click_button 'Log in'
      visit '/protected_pages/download_csv'
      expect(page).to have_content("Full Access Housing CSV Data")
    end

    it "is impossible to access page without being logged in" do
      visit '/protected_pages/download_csv'
      expect(page).to have_content("You need to sign in or sign up before continuing.")
    end

  end

end
