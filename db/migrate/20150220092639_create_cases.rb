class CreateCases < ActiveRecord::Migration
  def change
    create_table :cases do |t|
      t.string :case_number
      t.integer :case_number_integer
      t.string :title
      t.string :case_type
      t.string :case_status
      t.date :status_date
      t.date :file_date
      t.string :property_address
      t.string :plaintiff_name_original
      t.string :plaintiff_name_guess
      t.string :plaintiff_attorney_name
      t.string :defendants_json
      t.boolean :defendants_self_represented
      t.string :docket_information
      t.string :case_outcome
      t.date :case_outcome_date

      t.timestamps null: false
    end
  end
end
