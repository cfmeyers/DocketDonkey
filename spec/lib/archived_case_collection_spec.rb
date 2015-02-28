require 'parsed_housing_case'

describe ArchivedCaseCollection do
  let(:header_row) { ["case_number", "Title", "CaseType", "CaseStatus", "StatusDate", 
                      "FileDate", "PropertyAddress", "PlaintiffName", "PlaintiffAttorneyName", 
                      "Defendents", "DocketInformation", "CaseOutcome", "CaseOutcomeDate"] }

  let(:row1) { ["15H85SP000001", "15H85SP000001 Jones V Smith", "HCSP", "Active", "01/02/2015", "01/02/2015", 
                "123 Main Street" , "Jones", "Pro Se (PROPER)", "{\"Smith| Lori\": {\"attorney\": \"Pro Se (PROPER)\"| \"role\": \"Defendant\"}}", 
                "Docket Information...", "Agreement for Judgment", "01/15/2015"] }

  let(:row2) { ["15H85SP000002", "15H85SP000002 Adams V Parker", "HCSP", "Active", "01/02/2015", "01/02/2015", 
                "123 Main Street" , "Adams", "Pro Se (PROPER)", "{\"Smith| Lori\": {\"attorney\": \"Pro Se (PROPER)\"| \"role\": \"Defendant\"}}", 
                "Docket Information...", "Agreement for Judgment", "01/15/2015"] }

  it "takes a single argument" do
    expect{ArchivedCaseCollection.new}.to raise_error(ArgumentError)
  end

  it "discards the header" do
    contents_of_csv = [header_row, row1, row2]
    case_collection = ArchivedCaseCollection.new(contents_of_csv)
    expect(case_collection.cases.length).to be(2)
  end

  it "converts Housing Court cases CSV file contents into array of ParsedHousingCase objects" do
    contents_of_csv = [header_row, row1, row2]
    case_collection = ArchivedCaseCollection.new(contents_of_csv)
    expect(case_collection.cases[0].title).to eql(ParsedHousingCase.new(row1).title)
    expect(case_collection.cases[1].title).to eql(ParsedHousingCase.new(row2).title)
  end

  it "doesn't allow duplicate case rows" do
    contents_of_csv = [header_row, row1, row1]
    case_collection = ArchivedCaseCollection.new(contents_of_csv)
    expect(case_collection.cases.length).to be(1)
  end

  it "when given duplicate case numbers, keeps the row the most total characters" do
    contents_of_csv = [header_row, ["15H85SP000001", "", "", "", "", "", "" , nil, "", "", nil], row1] 
    case_collection = ArchivedCaseCollection.new(contents_of_csv)
    expect(case_collection.cases.length).to be(1)
    expect(case_collection.cases[0].title).to eq('15H85SP000001 Jones V Smith')
  end

end
