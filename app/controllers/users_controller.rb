class UsersController < ApplicationController
    
    get '/users' do
        if Helpers.is_logged_in?(session)
            @users = User.all
        else
            redirect '/'
        end
        erb :'users/index'
    end
    
    get '/signup' do
        if Helpers.is_logged_in?(session)
            user = Helpers.current_user(session)
            redirect to "/users/#{user.id}"
        end
        erb :'users/signup'
    end

    post '/signup' do
        user = User.create(username: params[:username], email: params[:email], password: params[:password])
        if user.valid?
            session[:user_id] = user.id 
            redirect to "/users/#{user.id}"
        else 
            redirect to '/signup'
        end
    end

    get '/users/:id' do
        if Helpers.is_logged_in?(session) && User.find_by(id: params[:id])
            @user = User.find_by(id: params[:id])
            @groceries = @user.groceries
        else
            redirect to '/login'
        end
        erb :'users/show'
    end


    get '/login' do
        if Helpers.is_logged_in?(session)
            user = Helpers.current_user(session)
            redirect to "/users/#{user.id}"
        end
        erb :'users/login'
    end
    
    post '/login' do 
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect to "users/#{user.id}"
        else
            flash[:danger] = "Incorrect username/password. Please try again!"
            erb :'users/login'
        end
    end

    get '/logout' do
        if Helpers.is_logged_in?(session)
            session.clear 
            flash[:primary] = "Goodbye!"
            redirect to '/login' 
        else
            redirect to "/login"
        end
    end

end