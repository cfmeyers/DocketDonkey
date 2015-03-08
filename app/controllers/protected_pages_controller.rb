class ProtectedPagesController < ApplicationController
  before_filter :authenticate_user!

  def download_csv
  end
end
