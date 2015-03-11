class User < ActiveRecord::Base
  attr_accessible :description, :password, :profile_picture, :username
end
