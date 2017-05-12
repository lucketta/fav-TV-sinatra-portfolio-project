class User < ActiveRecord::Base
  has_many :shows
  has_secure_password
end
