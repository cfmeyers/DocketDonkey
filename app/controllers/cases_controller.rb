class CasesController < ApplicationController

  
  def create
    @cases = Case.where("file_date > ? AND file_date < ?", params[:start], params[:complete])

    # respond_to do |format|
    #   format.csv {render text: @cases.to_csv}
    # end

    # render text:@cases.to_csv
    send_data @cases.to_csv, :filename => 'cases.csv'
  end

end
