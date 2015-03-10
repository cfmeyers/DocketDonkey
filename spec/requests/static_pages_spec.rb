require 'rails_helper'

RSpec.describe "StaticPages" do

  before do
    visit '/'
  end

  it "should display welcome message" do
    expect(page).to have_content('A hub for downloading Massachusetts Trial Court information as CSV files')
  end


end
