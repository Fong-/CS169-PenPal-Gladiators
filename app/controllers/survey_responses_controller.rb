class SurveyResponsesController < ApplicationController
    skip_filter :check_access_token

    def get_all
        render :json => SurveyResponse.all.map { |response| response.response_object }
    end

    def get_by_id
        response = SurveyResponse.find_by_id(params[:id])
        if response.nil?
            render_error(:resource_not_found) and return
        end

        render :json => response.response_object
    end
end
