require 'date'
require 'json'
require 'pry'

class CSVHeaderError < StandardError; end
class CSVNoCaseNumberError < StandardError; end
class CSVValueDoesNotExistError < StandardError; end

class HousingCSVParser

@@CSV_HEADER = ["case_number", "Title", "CaseType", "CaseStatus", "StatusDate", 
               "FileDate", "PropertyAddress", "PlaintiffName", "PlaintiffAttorneyName", 
               "Defendents", "DocketInformation", "CaseOutcome", "CaseOutcomeDate"]

  def initialize(row)
    raise(ArgumentError, ":row must be an array") unless row.is_a?(Array)
    raise(CSVHeaderError, ":row must not be the header row of the csv file") if row == @@CSV_HEADER
    raise(CSVNoCaseNumberError, "every row must have at least a case number") if (row[0] == "" || row[0].nil?)
    @row = row
  end

  def case_number
    @row[0].strip
  end

  def case_number_integer
    self.case_number.split('SP')[1].to_i
  end

  def title
    raise CSVValueDoesNotExistError if @row[1].nil?
    @row[1].strip 
  end

  def case_type
    raise CSVValueDoesNotExistError if @row[2].nil?
    @row[2].strip
  end

  def case_status
    raise CSVValueDoesNotExistError if @row[3].nil?
    @row[3].strip
  end

  def status_date
    raise CSVValueDoesNotExistError if @row[4].nil?
    Date.strptime(@row[4], '%m/%d/%Y')
  end

  def file_date
    raise CSVValueDoesNotExistError if @row[5].nil?
    Date.strptime(@row[5], '%m/%d/%Y')
  end

  def property_address
    raise CSVValueDoesNotExistError if @row[6].nil?
    @row[6].gsub("\n", " ")
  end

  def plaintiff_name_original
    raise CSVValueDoesNotExistError if @row[7].nil?
    @row[7].strip
  end

  def plaintiff_attorney_name
    raise CSVValueDoesNotExistError if @row[8].nil?
    @row[8].strip
  end

  def defendants_json
    raise CSVValueDoesNotExistError if @row[9].nil?
    JSON.parse(@row[9].strip.gsub('|', ',')).map do |item|
      {name: item[0], attorney: item[1]['attorney']}
    end
  end

  def defendants_self_represented
    raise CSVValueDoesNotExistError if @row[9].nil?
    self.defendants_json.each do |defendant|
      return false unless defendant[:attorney] == "Pro Se (PROPER)"
    end
    true
  end

  def docket_information
    raise CSVValueDoesNotExistError if @row[10].nil?
    @row[10].strip
  end

  def case_outcome
    raise CSVValueDoesNotExistError if @row[11].nil?
    @row[11].strip
  end

  def case_outcome_date
    raise CSVValueDoesNotExistError if @row[12].nil?
    Date.strptime(@row[12], '%m/%d/%Y')
  end

  def self.truncate_name(name)
    name.downcase.gsub(',', '').gsub(' ', '').gsub('.', '').gsub('-', '').gsub('/', '').gsub('s', '')
  end

  def self.fuzzy_name_match(name, dictionary)
    fingerprint = truncate_name(name)

    return [dictionary[fingerprint], dictionary] if dictionary[fingerprint]

    dictionary.keys.each do |key|
      return [dictionary[key], dictionary] if key.include?(fingerprint) && fingerprint.length > 5
    end

    dictionary[fingerprint] = name
    [name,dictionary]
  end

end
