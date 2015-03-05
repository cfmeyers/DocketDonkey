require 'rails_helper'

RSpec.describe User, :type => :model do

  describe "when approved email and password are present" do
    it "should validate a cla-ma.org email address" do
      expect(User.new({email:'bob@cla-ma.org', password:'12345678'})).to be_valid
    end
    it "should validate a cfmeyers.com email address" do
      expect(User.new({email:'bob@cfmeyers.com', password:'12345678'})).to be_valid
    end

  end

  describe "when email not present" do
    it "should not validate" do
      expect(User.new({password:'12345678'})).to be_invalid
    end
  end

  describe "when unapproved email present" do
    it "should not validate" do
      expect(User.new({email:'bob@gmail.com', password:'12345678'})).to be_invalid
    end
  end

end
