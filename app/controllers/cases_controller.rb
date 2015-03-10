class CasesController < ApplicationController

  
  def create
    @cases = Case.where("file_date > ? AND file_date < ?", params[:start], params[:complete])

    send_data @cases.to_csv, :filename => 'cases.csv'
  end

end
