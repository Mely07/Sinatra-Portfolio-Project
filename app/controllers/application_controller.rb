require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
    use Rack::Flash, :sweep => true
  end

  get "/" do
    erb :welcome
  end

  helpers do 
    def redirect_if_not_logged_in
      if !Helpers.is_logged_in?(session)
        redirect '/login'
      end
    end

  end

end
