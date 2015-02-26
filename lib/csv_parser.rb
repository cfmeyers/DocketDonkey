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
    unless (@row[1].nil? || @row[1].empty?) 
      @row[1].strip
    else
      nil
    end
  end

  def case_type
    unless (@row[2].nil? || @row[2].empty?) 
      @row[2].strip
    else
      nil
    end
  end

  def case_status
    unless (@row[3].nil? || @row[3].empty?) 
      @row[3].strip
    else
      nil
    end
  end

  def status_date
    unless (@row[4].nil? || @row[4].empty?) 
      Date.strptime(@row[4], '%m/%d/%Y')
    else
      nil
    end
  end

  def file_date
    unless (@row[5].nil? || @row[5].empty?) 
      Date.strptime(@row[5], '%m/%d/%Y')
    else
      nil
    end
  end

  def property_address
    unless (@row[6].nil? || @row[6].empty?)
      @row[6].gsub("\n", " ") 
    else
      nil
    end
  end

  def plaintiff_name_original
    unless (@row[7].nil? || @row[7].empty?) 
      @row[7].strip
    else
      nil
    end
  end

  def plaintiff_attorney_name
    unless (@row[8].nil? || @row[8].empty?) 
      @row[8].strip
    else
      nil
    end
  end

  def defendants_json
    unless (@row[9].nil? || @row[9].empty?)
      JSON.parse(@row[9].strip.gsub('|', ',')).map do |item|
        {name: item[0], attorney: item[1]['attorney']}
      end
    else
      nil
    end
  end

  def defendants_self_represented
    unless @row[9].nil? || @row[9].empty?
      self.defendants_json.each do |defendant|
        return false unless defendant[:attorney] == "Pro Se (PROPER)"
      end
      return true
    else
      nil
    end
  end

  def docket_information
    unless (@row[10].nil? || @row[10].empty?) 
      @row[10].strip
    else
      nil
    end
  end

  def case_outcome
    unless (@row[11].nil? || @row[11].empty?) 
      @row[11].strip
    else
      nil
    end
  end

  def case_outcome_date
    unless (@row[12].nil? || @row[12].empty?) 
      Date.strptime(@row[12], '%m/%d/%Y') 
    else
      nil
    end
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
