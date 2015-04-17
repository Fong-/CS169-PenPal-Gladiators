class TopicsController < ApplicationController
    skip_filter :check_access_token

    def get_all
        render :json => Topic.all.map { |topic| topic.response_object }
    end

    def get_by_id
        topic = Topic.find_by_id(params[:id])
        if topic.nil?
            render_error(:resource_not_found) and return
        end

        render :json => topic.response_object
    end

    def get_questions_by_id
        topic = Topic.find_by_id(params[:id])
        if topic.nil?
            render_error(:resource_not_found) and return
        end

        questions = topic.survey_questions
        render :json => questions.map { |q| q.response_object }
    end
end
