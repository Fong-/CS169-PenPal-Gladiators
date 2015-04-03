class ApplicationController < ActionController::Base
    def homepage
        # TODO Move to angular controller.
        render :file => "public/homePage.html"
    end
end
