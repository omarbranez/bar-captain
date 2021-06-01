class UsersController < ApplicationController

    get '/users/:slug' do
        redirect_if_not_logged_in
        @user = User.find_by_slug(params[:slug])
        erb :'users/show'
    end
    
    get '/new' do
        redirect_if_logged_in
        erb :'users/new' 
    end

    post '/users' do
        if params[:username] != "" && params[:password] != ""
            user = User.new(:username => params[:username], :password => params[:password])
            user.save
            session[:user_id] = user.id 
            flash[:message] = "Successfully Registered!"
            redirect to "/users/#{user.slug}"
        else
            redirect '/new'
        end
    end

end