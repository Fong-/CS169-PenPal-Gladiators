include AccessTokenHelper

class ApplicationController < ActionController::Base
    def homepage
        render :file => "public/homePage.html"
    end
end
