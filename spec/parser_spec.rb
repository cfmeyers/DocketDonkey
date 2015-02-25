require 'csv_parser'
require 'date'

$ROW_1 = ["15H85SP000001",
         "15H85SP000001 Jones, Alan Van vs. Smith, Bob et al",
         "Housing Court Summary Process",
         "Active",
         "01/02/2015",
         "01/02/2015",
         "123 Main Street 5L\nWorcester MA 01610",
         "Jones, Alan Van",
         "Pro Se (PROPER)",
         "{\"Smith| Lori\": {\"attorney\": \"Pro Se (PROPER)\"| \"role\": \"Defendant\"}| \"Smith| Bob\": {\"attorney\": \"Pro Se (PROPER)\"| \"role\": \"Defendant\"}}",
         "Docket Information\nDocket File Ref Nbr.\n01/02/2015 Summary Process: MGL Chapter 185C Section 19;...",
         "Agreement for Judgment",
         "01/15/2015"]

describe HousingCSVParser do

  it "needs to be initialized with a row" do
    expect{HousingCSVParser.new}.to raise_error(ArgumentError)
  end

  it "will raise an error if given a header row" do
    expect{ HousingCSVParser.new(["case_number", "Title", "CaseType", "CaseStatus", "StatusDate", 
               "FileDate", "PropertyAddress", "PlaintiffName", "PlaintiffAttorneyName", 
               "Defendents", "DocketInformation", "CaseOutcome", "CaseOutcomeDate"]) }.to raise_error(CSVHeaderError)
  end

  it "will raise an error if given a row without a case_number field" do
    expect{HousingCSVParser.new((["", "", "", "", "", "", "", "", "", "", "", "", ""]))}.to raise_error(CSVNoCaseNumberError)
    expect{HousingCSVParser.new(([nil, "", "", "", "", "", "", "", "", "", "", "", ""]))}.to raise_error(CSVNoCaseNumberError)
  end

  describe "a well-formed csv row" do
    subject { HousingCSVParser.new($ROW_1) }
    specify { expect(subject.case_number).to eq "15H85SP000001" }
    specify { expect(subject.case_number_integer).to be 1 }
    specify { expect(subject.title).to eq "15H85SP000001 Jones, Alan Van vs. Smith, Bob et al" }
    specify { expect(subject.case_type).to eq "Housing Court Summary Process" }
    specify { expect(subject.case_status).to eq "Active" }
    specify { expect(subject.status_date).to eq Date.parse("2/01/2015") }
    specify { expect(subject.file_date).to eq Date.parse("2/01/2015") }
    specify { expect(subject.property_address).to eq "123 Main Street 5L Worcester MA 01610" }
    specify { expect(subject.plaintiff_name_original).to eq "Jones, Alan Van" }
    specify { expect(subject.plaintiff_attorney_name).to eq "Pro Se (PROPER)" }
    specify { expect(subject.defendants_json).to eq [ {name: "Smith, Lori", attorney: "Pro Se (PROPER)"}, {name: "Smith, Bob", attorney: "Pro Se (PROPER)"} ] }
    specify { expect(subject.defendants_self_represented).to eq true }
    specify { expect(subject.docket_information).to eq "Docket Information\nDocket File Ref Nbr.\n01/02/2015 Summary Process: MGL Chapter 185C Section 19;..." }
    specify { expect(subject.case_outcome).to eq "Agreement for Judgment" }
    specify { expect(subject.case_outcome_date).to eq Date.parse("15/01/2015") }
  end

  describe "a csv row missing information" do
    subject { HousingCSVParser.new(["15H85SP000001"]) }
    it "raises an undefined value error whenever a field is undefined" do
      methods = [:title, :case_type, :case_status, :status_date, :file_date,
                 :property_address, :plaintiff_name_original, :plaintiff_attorney_name, 
                 :defendants_json, :defendants_self_represented, :docket_information,
                 :case_outcome, :case_outcome_date]

      methods.each do |method_name|
        expect{subject.send(method_name)}.to raise_error(CSVValueDoesNotExistError)
      end
    end
  end

  describe '.truncate_name' do
    it "downcases and removes commas, periods, spaces, dashes, and all 's' characters" do
      expect(HousingCSVParser.truncate_name('one-TWO three,four/fives')).to eq('onetwothreefourfive')
    end
  end

  describe '.fuzzy_name_match' do
    it "takes two arguments" do
      expect{HousingCSVParser.fuzzy_name_match}.to raise_error(ArgumentError)
    end

    describe "when the fingerprint is not in the dictionary" do
      it "returns the name as its first return value" do
        expect(HousingCSVParser.fuzzy_name_match("some name", {})[0]).to eq("some name")
      end
      it "adds {name: fingerprint} to the dictionary and returns that as the second return value" do
        expect(HousingCSVParser.fuzzy_name_match("some name", {})[1]).to eq({"omename" => "some name"})
      end
    end

    describe "when the fingerprint is in the dictionary" do
      it "returns the the name that corresponds to the fingerprint as its first return value" do
        expect(HousingCSVParser.fuzzy_name_match("some name", {'omename' => 'bob'})[0]).to eq('bob')
      end
      it "returns the same dictionary as the second return value" do
        expect(HousingCSVParser.fuzzy_name_match("some name", {'omename' => 'bob'})[1]).to eq({'omename' => 'bob'})
      end
    end

    describe "when the fingerprint.length > 5  and is a substring of a fingerprint in the dictionary" do
      it "returns the name that corresponds to the substring of the fingerprint in the dictionary" do
        expect(HousingCSVParser.fuzzy_name_match("some name", {'jubjubomename' => 'bob'})[0]).to eq('bob')
      end

    end


  end

end
