class GroceriesController < ApplicationController
    get '/groceries' do
        @groceries = Grocery.all
        erb :'groceries/index'
    end
    
    get '/groceries/new' do
        if !Helpers.is_logged_in?(session)
            redirect '/'
        end
        erb :'groceries/new'
    end

    post '/groceries' do
        grocery = Grocery.create(params)
        user = Helpers.current_user(session)
        grocery.user = user
        grocery.save
        redirect to "/users/#{user.id}"
    end

    get '/groceries/:id' do
        if !Helpers.is_logged_in?(session)
            redirect '/login'
        end
        @grocery = Grocery.find_by(id: params[:id])
        if !@grocery 
            user = Helpers.current_user(session)
            redirect to "/users/#{user.id}"
        end
        erb :'groceries/show'
    end

    get '/groceries/:id/edit' do
        @grocery = Grocery.find_by(id: params[:id])
        if !Helpers.is_logged_in?(session) || !@grocery || @grocery.user != Helpers.current_user(session)
            redirect '/login'
        end
        erb :'groceries/edit'
    end


    patch '/groceries/:id' do
        grocery = Grocery.find_by(id: params[:id])
        if grocery && grocery.user == Helpers.current_user(session)
            grocery.update(params[:grocery])
            redirect to "/groceries/#{grocery.id}"
        else 
            redirect to '/groceries'
        end
    end

    delete '/groceries/:id' do 
        grocery = Grocery.find_by(id: params[:id])
        if grocery && grocery.user == Helpers.current_user(session)
           grocery.destroy 
           redirect to "/groceries/#{grocery.id}"
        end
            redirect to '/'
    end

end