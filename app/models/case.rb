class Case < ActiveRecord::Base

  def self.to_csv(public_fields)
    
    CSV.generate do |csv|
      csv << public_fields 

      all.each do |kase|
        values = public_fields.map do |field|
          kase[field]
        end
        csv << values
      end

    end

  end

  # def self.to_xls(public_fields)

  #   workbook = RubyXL::Workbook.new
  #   sheet = workbook.worksheets[0]

  #   public_fields.each_with_index { |field, column| sheet.add_cell(0, column, field) }

  #   all.each.with_index(1) do |kase, row|

  #     public_fields.each_with_index do |field, column|
  #       sheet.add_cell(row, column, kase[field])
  #     end

  #   end

  #   workbook.stream.string
  # end

end
