require 'csv'
require './lib/parsed_housing_case'

Case.delete_all

cases = []

Dir['./data/*'].each do |filename|
# ['./data/mc2014_complete.csv'].each do |filename|
  puts "Loading cases from " + filename
  archived_cases = ArchivedCaseCollection.new(CSV.read(filename))
  cases += archived_cases.cases
end

fuzzy_match_dictionary = {}
cases.each do |kase|
  puts kase if kase.plaintiff_name_original.nil?
  guess, fuzzy_match_dictionary = ParsedHousingCase.fuzzy_name_match(kase.plaintiff_name_original, fuzzy_match_dictionary)
  new_case = Case.new(kase.to_h)
  new_case.plaintiff_name_guess = guess
  new_case.save!
end

# puts cases.length
# puts fuzzy_match_dictionary.length

