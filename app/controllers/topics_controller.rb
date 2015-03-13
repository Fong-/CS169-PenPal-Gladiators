class TopicsController < ApplicationController
    def get_all
        render :json => Topic.all.map { |topic| topic.response_object }
    end

    def get_by_id
        topic = Topic.find_by_id params[:id]
        render :json => topic.nil? ? {"error" => true} : topic.response_object
    end

    def get_questions_by_id
        topic = Topic.find_by_id params[:id]
        if topic.nil?
            render :json => {"error" => true}
        questions = topic.survey_questions
        render :json => questions.map { |q| q.response_object }
    end
end
