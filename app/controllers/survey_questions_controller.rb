class SurveyQuestionsController < ApplicationController
    skip_filter :check_access_token

    def get_all
        render :json => SurveyQuestion.all.map { |question| question.response_object }
    end

    def get_by_id
        question = SurveyQuestion.find_by_id(params[:id])
        if question.nil?
            render_error(:resource_not_found) and return
        end

        render :json => question.response_object
    end

    def get_responses_by_id
        question = SurveyQuestion.find_by_id(params[:id])
        if question.nil?
            render_error(:resource_not_found) and return
        end

        responses = question.survey_responses
        render :json => responses.map { |r| r.response_object }
    end
end
