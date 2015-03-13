class TopicsController < ApplicationController
    def get_all
        render :json => Topic.all.map { |topic| topic.response_object }
    end

    def get_by_id
        topic = Topic.find_by_id params[:id]
        render :json => topic.nil? ? {"error" => true} : topic.response_object
    end
end
