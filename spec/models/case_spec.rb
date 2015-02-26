require 'rails_helper'

# RSpec.describe Case, :type => :model do
#   describe ".create_from_housing_CSV_parser" do
#     let(:parsed_row) { 
#       HousingCSVParser.new( 
#            ["15H85SP000001",
#              "15H85SP000001 Jones, Alan Van vs. Smith, Bob et al",
#              "Housing Court Summary Process",
#              "Active",
#              "01/02/2015",
#              "01/02/2015",
#              "123 Main Street 5L\nWorcester MA 01610",
#              "Jones, Alan Van",
#              "Pro Se (PROPER)",
#              "{\"Smith| Lori\": {\"attorney\": \"Pro Se (PROPER)\"| \"role\": \"Defendant\"}| \"Smith| Bob\": {\"attorney\": \"Pro Se (PROPER)\"| \"role\": \"Defendant\"}}",
#              "Docket Information\nDocket File Ref Nbr.\n01/02/2015 Summary Process: MGL Chapter 185C Section 19;...",
#              "Agreement for Judgment",
#              "01/15/2015"]) 
#     }

#     it "creates a new case record in the database" do
#       # expect{ Case.create_from_housing_CSV_parser(parsed_row) }.to change{Case.all.length}.by(1)
#       expect{ Case.create_from_housing_CSV_parser(parsed_row) }.to change{Case.all.length}.by(1)
#       # expect(Case.all.length).to eq(0)
#       # Case.create_from_housing_CSV_parser(parsed_row)
#       # expect(Case.all.length).to eq(1)
#     end
#   end
# end
