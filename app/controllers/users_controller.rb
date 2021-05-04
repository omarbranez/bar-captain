class UsersController < ApplicationController

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :'users/show'
    end
    
    get '/signup' do
        if logged_in?
            redirect '/menu'
        else
            erb :'users/signup' 
        end
    end

    post '/signup' do
        if params[:username] != "" && params[:password] != ""
            @user = User.new(:username => params[:username], :password => params[:password])
            @user.save
            session[:user_id] = @user.id 
            flash[:message] = "Successfully Registered!"
            redirect to "/users/#{@user.slug}"
        else
            redirect '/signup'
        end
    end

    get '/login' do
        if logged_in?
            redirect '/menu'
        else
            erb :'users/login'
        end
    end
    
    post '/login' do
        # binding.pry
        user = User.find_by_slug(params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            flash[:message] = "Successfully Logged In!"
            redirect to "/users/#{user.slug}"
        else
            redirect '/signup'
        end
    end

    get '/logout' do
        if logged_in?
            session.clear
            redirect '/login'
        else
            redirect to '/'
        end
    end

end