class SessionsController < ApplicationController

    get '/login' do
        redirect_if_logged_in
        erb :'sessions/login'
    end

    post '/login' do
        user = User.find_by_slug(params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            flash[:message] = "Successfully Logged In!"
            redirect to "/users/#{user.slug}"
        else
            flash[:message] = "Invalid Login"
            redirect '/login'
        end
    end
    
    get '/logout' do
        if logged_in?
            session.clear
            erb :'sessions/logout'
        else
            redirect '/'
        end
    end

end