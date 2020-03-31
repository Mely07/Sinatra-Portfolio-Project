class User < ActiveRecord::Base 
    has_many :groceries

    has_secure_password
end