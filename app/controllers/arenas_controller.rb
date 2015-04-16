class ArenasController < ApplicationController
    def get_by_user_id
        user = User.find_by_id(params[:user_id])
        if user.nil?
            render_error(:resource_not_found) and return
        end

        result = []
        user.arenas.each do |arena|
            result.push arena.response_object
        end
        render :json => result
    end
end
