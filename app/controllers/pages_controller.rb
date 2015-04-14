class PagesController < ApplicationController
    def homepage
        render "public/homePage", :formats => :html
    end

    def startpage
        render "public/startPage", :formats => :html
    end
end
