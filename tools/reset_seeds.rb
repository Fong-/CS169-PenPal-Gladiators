tables = [ResponseWeight, SurveyQuestion, SurveyResponse, Topic]

tables.each do |table|
    table.all.each do |element|
        element.destroy
    end
end

