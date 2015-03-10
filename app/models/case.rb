class Case < ActiveRecord::Base

# case_number
# case_number_integer
# title
# case_type
# case_status
# status_date
# file_date
# property_address
# plaintiff_name_original
# plaintiff_name_guess
# plaintiff_attorney_name
# defendants_json
# defendants_self_represented
# docket_information
# case_outcome
# case_outcome_date

  def self.to_csv
    public_fields = ['case_number', 'case_type', 'case_status', 'status_date', 'file_date', 'plaintiff_name_original', 'plaintiff_name_guess', 'plaintiff_attorney_name', 'defendants_self_represented', 'case_outcome', 'case_outcome_date']
    
    # public_fields = ['file_date']


    CSV.generate do |csv|
      csv << public_fields 

      all.each do |kase|
        values = public_fields.map do |field|
          kase[field]
        end
        csv << values
      end

    end

  end
end
