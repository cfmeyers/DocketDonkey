class CasesController < ApplicationController

  
  def create
    @cases = Case.where("file_date > ? AND file_date < ?", params[:start], params[:complete]).order('case_number')
    if user_signed_in?
      public_fields = ['case_number', 'case_number_integer', 'title', 'case_type', 
                       'case_status', 'status_date', 'file_date', 'property_address', 
                       'plaintiff_name_original', 'plaintiff_name_original','plaintiff_name_guess', 
                       'plaintiff_attorney_name', 'defendants_json', 'defendants_self_represented', 
                       'docket_information','case_outcome', 'case_outcome_date']
    else
      public_fields = ['case_number', 'case_number_integer', 'case_type', 'case_status', 
                       'status_date', 'file_date', 'plaintiff_name_original', 
                       'plaintiff_name_guess', 'plaintiff_attorney_name', 
                       'defendants_self_represented', 'case_outcome', 'case_outcome_date']
    end

    respond_to do |format|
      format.csv { send_data @cases.to_csv(public_fields), :filename => 'cases.csv' }
      format.xls { send_data @cases.to_xls(public_fields), filename: 'cases.xls' }
    end

  end

end
