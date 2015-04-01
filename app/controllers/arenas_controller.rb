class ArenasController < ApplicationController
    def get_by_user_id
        result = []
        User.find(params[:user_id]).arenas.each do |arena|
            result.push arena.response_object
        end
        render :json => result
    end
end
