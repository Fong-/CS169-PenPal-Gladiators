class ApplicationController < ActionController::Base
    def homepage
        # TODO Move to angular controller.
        render "public/homePage", :formats => :html
    end
end
