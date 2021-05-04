require './config/environment'
require 'sinatra'
require 'sinatra/flash'
class ApplicationController < Sinatra::Base

    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
        enable :sessions
        set :session_secret, "totallynotasecret"
        register Sinatra::Flash
    end

    get '/' do
        flash[:notice] = "Hooray, Flash is working!"
        erb :index
    end

    helpers do 
        
        def logged_in?
            !!session[:user_id] 
        end

        def current_user
            User.find(session[:user_id])
        end

        def redirect_if_not_logged_in
            if !logged_in?
                redirect '/login'
            end
        end

        def redirect_if_logged_in
            if logged_in?
                redirect '/menu'
            end
        end

        def redirect_if_not_owner(menu)
            if menu_id && menu_id.user != current_user
                flash[:notice] = "Moe Szyzlak is pulling out his shotgun..."
                redirect '/menu'
            end
        end
    end

end