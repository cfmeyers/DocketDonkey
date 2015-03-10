require 'rails_helper'

RSpec.describe Case, :type => :model do

  let(:csv1) do
    header = "case_number,case_type,case_status,status_date,file_date,plaintiff_name_original,plaintiff_name_guess,plaintiff_attorney_name,defendants_self_represented,case_outcome,case_outcome_date\n"
    row1 = "10H85SP000001,Housing Court Summary Process,Closed,2010-01-22,2010-01-04,\"Smith, Alice\",\"Smith, Alice\",Pro Se (PROPER),true,Judgment in SP by Default,2010-01-22\n"
    row2 ="10H85SP000002,Housing Court Summary Process,Closed,2010-01-22,2010-01-04,\"Roberts, Armando\",\"Roberts, Armando\",Pro Se (PROPER),true,Judgment in SP by Default,2010-01-22\n"
    header + row1 + row2
  end

  let(:csv2) do
    header = "case_number,case_number_integer,title,case_type,case_status,status_date,file_date,property_address,plaintiff_name_original,plaintiff_name_original,plaintiff_name_guess,plaintiff_attorney_name,defendants_json,defendants_self_represented,docket_information,case_outcome,case_outcome_date\n"

    row1 = "10H85SP000001,"+
      "1,"+
      "\"10H85SP000001 Smith, Alice vs. Jones, Eve\","+
      "Housing Court Summary Process,"+
      "Closed,"+
      "2010-01-22,2010-01-04,"+
      "2525 Main Street Worcester MA 01603,"+
      "\"Smith, Alice\",\"Smith, Alice\",\"Smith, Alice\","+
      "Pro Se (PROPER),"+
      "\"[{:name=>\"\"Jones, Michael\"\", :attorney=>\"\"Pro Se (PROPER)\"\"}, {:name=>\"\"Jones, Eve\"\", :attorney=>\"\"Pro Se (PROPER)\"\"}]\","+
      "true,"+
      "\"Docket Information\nDocket Date Docket Text File Ref Nbr.\n01/04/2010 SP Summons and Complaint - Non-payment of Rent\","+
      "Judgment in SP by Default,"+
      "2010-01-22\n"

    row2 = "10H85SP000002,"+
      "2,"+
      "\"10H85SP000001 Roberts, Armando vs. Jones, Eve\","+
      "Housing Court Summary Process,Closed,"+
      "2010-01-22,2010-01-04,2525 Main Street Worcester MA 01603,"+
      "\"Roberts, Armando\",\"Roberts, Armando\",\"Roberts, Armando\","+
      "Pro Se (PROPER),\"[{:name=>\"\"Jones, Michael\"\", :attorney=>\"\"Pro Se (PROPER)\"\"}, {:name=>\"\"Jones, Eve\"\", :attorney=>\"\"Pro Se (PROPER)\"\"}]\","+
      "true,"+
      "\"Docket Information\nDocket Date Docket Text File Ref Nbr.\n01/04/2010 SP Summons and Complaint - Non-payment of Rent\","+
      "Judgment in SP by Default,"+
      "2010-01-22\n"

    header + row1 + row2
  end

  before do
    @case1 = Case.create!(case_number: "10H85SP000001", 
                 case_number_integer: 1,
                 title: "10H85SP000001 Smith, Alice vs. Jones, Eve",
                 case_type: "Housing Court Summary Process",
                 case_status: "Closed",
                 status_date: Date.parse('22 Jan 2010'),
                 file_date: Date.parse('04 Jan 2010'),
                 property_address: "2525 Main Street Worcester MA 01603",
                 plaintiff_name_original: "Smith, Alice",
                 plaintiff_name_guess: "Smith, Alice",
                 plaintiff_attorney_name: "Pro Se (PROPER)",
                 defendants_json: "[{:name=>\"Jones, Michael\", :attorney=>\"Pro Se (PROPER)\"}, {:name=>\"Jones, Eve\", :attorney=>\"Pro Se (PROPER)\"}]",
                 defendants_self_represented: true,
                 docket_information: "Docket Information\nDocket Date Docket Text File Ref Nbr.\n01/04/2010 SP Summons and Complaint - Non-payment of Rent",
                 case_outcome: "Judgment in SP by Default",
                 case_outcome_date: Date.parse('22 Jan 2010'))

    @case2 = Case.create!(case_number: "10H85SP000002", 
                 case_number_integer: 2,
                 title: "10H85SP000001 Roberts, Armando vs. Jones, Eve",
                 case_type: "Housing Court Summary Process",
                 case_status: "Closed",
                 status_date: Date.parse('22 Jan 2010'),
                 file_date: Date.parse('04 Jan 2010'),
                 property_address: "2525 Main Street Worcester MA 01603",
                 plaintiff_name_original: "Roberts, Armando",
                 plaintiff_name_guess: "Roberts, Armando",
                 plaintiff_attorney_name: "Pro Se (PROPER)",
                 defendants_json: "[{:name=>\"Jones, Michael\", :attorney=>\"Pro Se (PROPER)\"}, {:name=>\"Jones, Eve\", :attorney=>\"Pro Se (PROPER)\"}]",
                 defendants_self_represented: true,
                 docket_information: "Docket Information\nDocket Date Docket Text File Ref Nbr.\n01/04/2010 SP Summons and Complaint - Non-payment of Rent",
                 case_outcome: "Judgment in SP by Default",
                 case_outcome_date: Date.parse('22 Jan 2010'))
  end

  it "holds all cases saved to the database" do
    expect(Case.all.length).to be(2)
  end

  describe "#to_csv" do
    
    it "returns a csv string with fields containing no personal defendant data" do

      public_fields = ['case_number', 'case_type', 'case_status', 
                       'status_date', 'file_date', 'plaintiff_name_original', 
                       'plaintiff_name_guess', 'plaintiff_attorney_name', 
                       'defendants_self_represented', 'case_outcome', 'case_outcome_date']
      
      expect(Case.all.to_csv(public_fields)).to eq(csv1)
    end

    it "returns a csv string with all the possible fields" do

      public_fields = ['case_number', 'case_number_integer', 'title', 'case_type', 
                       'case_status', 'status_date', 'file_date', 'property_address', 
                       'plaintiff_name_original', 'plaintiff_name_original','plaintiff_name_guess', 
                       'plaintiff_attorney_name', 'defendants_json', 'defendants_self_represented', 
                       'docket_information','case_outcome', 'case_outcome_date']

      expect(Case.all.to_csv(public_fields)).to eq(csv2)
    end

  end

end
