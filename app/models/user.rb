class User < ActiveRecord::Base 
    has_many :groceries

    validates :username, presence: true, uniqueness: true #from AR::Base, ensures unqiue username is entered
    validates :email, presence: true, uniqueness: true #from AR::Base, ensures unqiue username is entered
    #pw validation
     
    has_secure_password
end