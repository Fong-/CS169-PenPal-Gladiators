class SurveyResponsesController < ApplicationController
    def get_all
        render :json => SurveyResponses.all.map { |response| response.response_object }
    end

    def get_by_id
        response = SurveyResponses.find_by_id params[:id]
        render :json => response.nil? ? {"error" => true} : response.response_object
    end
end