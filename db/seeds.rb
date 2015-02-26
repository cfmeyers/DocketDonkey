require 'csv'
require 'pp'
require './lib/csv_parser'

plaintiff_name_fingerprint = {}
plaintiff_name_matches = {}
cases = []
rows = CSV.read('data/mc2014_complete.csv')
rows.shift #get rid of header row

rows.each do |row|
  new_case = HousingCSVParser.new(row)
  # puts new_case.case_number
  if new_case.case_number == '14H85SP005241'
    pp new_case
    puts "---------------------"
  end
  # kase = Case.new({case_number: new_case.case_number})

end

puts cases.length



# require 'csv'
# require 'pry'
# require 'pp' 
# require 'date'
# require 'json'

# plaintiff_name_fingerprint = Hash.new()

# # rows = CSV.read('data/mc2014_complete.csv')
# rows = CSV.read('data/mc2015_02_15.csv')
# def case_number_integer(case_number)
#   case_number.split('SP')[1].to_i
# end


# def name_guesser(name, plaintiff_name_fingerprint)

#   guess = name.downcase.gsub(',', '').gsub('.', '').gsub(' ', '').gsub('/','').gsub('s','').gsub('-','')

#   if guess.length>5
#     plaintiff_name_fingerprint.keys.each do |key|
#       return plaintiff_name_fingerprint[key] if key.include?(guess) #substring
#       return plaintiff_name_fingerprint[key] if (guess.length > 18 && key.include?(guess[1..18]))
#     end
#   end

#   plaintiff_name_fingerprint[guess] = name
#   return name

# end

# def parse_defendant(defendant)
#   JSON.parse(defendant.gsub('|',','))
# end

# def hashify_row(row, plaintiff_name_fingerprint) 
#   hash = {}
#   hash['case_number'] = row[0]
#   hash['case_number_integer'] = case_number_integer(row[0]) 
#   hash['title'] = row[1]
#   hash['case_type'] = row[2]
#   hash['case_status'] = row[3] #can be 'Active' or 'Closed'

#   begin
#     hash['status_date'] = Date.strptime(row[4], '%m/%d/%Y')
#   rescue
#     hash['status_date'] = nil
#   end

#   begin
#     hash['file_date'] = Date.strptime(row[5], '%m/%d/%Y')
#   rescue
#     hash['file_date'] = nil
#   end

#   begin
#     hash['property_address'] = row[6].delete("\n") #remove newlines in address
#   rescue
#     hash['property_address'] = ''
#   end

#   begin
#     hash['plaintiff_name_original'] = row[7].strip
#     hash['plaintiff_name_guess'] = name_guesser(row[7].strip, plaintiff_name_fingerprint)
#   rescue
#     hash['plaintiff_name_original'] = ''
#     hash['plaintiff_name_guess'] = ''
#   end

#   hash['plaintiff_attorney_name'] = row[8]

#   hash['defendants_json'] = parse_defendant(row[9])
#   hash['defendants_self_represented'] = true
#   hash['defendants_json'].each do |defendant_array|
#     hash['defendants_self_represented'] = false if defendant_array[1]['attorney'] != "Pro Se (PROPER)"
#   end

#   hash['docket_information'] = row[10]
#   hash['case_outcome'] = row[11]
#   begin
#     hash['case_outcome_date'] = Date.strptime(row[12], '%m/%d/%Y')
#   rescue
#     hash['case_outcome_date'] = nil
#   end
#   hash
# end

# rows.shift #get rid of header

# rows.each_with_index do |row, i|
#   row_hash = hashify_row(row, plaintiff_name_fingerprint)
#   Case.create(row_hash)
# end

