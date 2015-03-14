require 'csv'
require './lib/parsed_housing_case'

Case.delete_all

cases = []

Dir['./data/*'].each do |filename|
# ['./data/worcester_housing_2008_complete.csv'].each do |filename|
  puts "Loading cases from " + filename
  archived_cases = ArchivedCaseCollection.new(CSV.read(filename))
  cases += archived_cases.cases
end
puts "done loading"

fuzzy_match_dictionary = {}
p cases[0]
cases.each_with_index do |kase, index|
  begin
    puts kase if kase.plaintiff_name_original.nil?
    guess, fuzzy_match_dictionary = ParsedHousingCase.fuzzy_name_match(kase.plaintiff_name_original, fuzzy_match_dictionary)
    new_case = Case.new(kase.to_h)
    new_case.plaintiff_name_guess = guess
    new_case.save!
    puts index if index % 1000 == 0
  rescue
    puts "failed on line" + index.to_s
  end
end

# puts cases.length
# puts fuzzy_match_dictionary.length

