class Helpers 
    def self.current_user(session)
      User.find_by(id: session[:user_id]) #finding user by user_id inside session 
    end
    
    def self.is_logged_in?(session)
      session[:user_id] ? true : false
    end
end