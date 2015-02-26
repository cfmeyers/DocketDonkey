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
    @row[1] ? @row[1].strip : nil
  end

  def case_type
    @row[2] ? @row[2].strip : nil
  end

  def case_status
    @row[3] ? @row[3].strip : nil
  end

  def status_date
    @row[3] ? Date.strptime(@row[4], '%m/%d/%Y') : nil
  end

  def file_date
    @row[5] ? Date.strptime(@row[5], '%m/%d/%Y') : nil
  end

  def property_address
    @row[6] ? @row[6].gsub("\n", " ") : nil
  end

  def plaintiff_name_original
    @row[7] ? @row[7].strip : nil
  end

  def plaintiff_attorney_name
    @row[8] ? @row[8].strip : nil
  end

  def defendants_json
    unless @row[9].nil?
      JSON.parse(@row[9].strip.gsub('|', ',')).map do |item|
        {name: item[0], attorney: item[1]['attorney']}
      end
    else
      nil
    end
  end

  def defendants_self_represented
    unless @row[9].nil?
      self.defendants_json.each do |defendant|
        return false unless defendant[:attorney] == "Pro Se (PROPER)"
      end
      return true
    else
      nil
    end
  end

  def docket_information
    @row[10] ? @row[10].strip : nil
  end

  def case_outcome
    @row[11] ? @row[11].strip : nil
  end

  def case_outcome_date
    @row[12] ? Date.strptime(@row[12], '%m/%d/%Y') : nil
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
