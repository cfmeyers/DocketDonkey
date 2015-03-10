require 'rails_helper'

RSpec.describe "StaticPages" do

  it "should display welcome message" do
    visit '/'
    expect(page).to have_content('A hub for downloading Massachusetts Trial Court information as CSV files')
  end

end
