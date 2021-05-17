require './config/environment'
require 'sinatra'
require 'sinatra/base'
require 'sinatra/flash'


class ApplicationController < Sinatra::Base
    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
        enable :sessions
        set :session_secret, ENV["SESSION_SECRET"]
        register Sinatra::Flash
    end

    get '/' do
        flash[:notice] = "Sign In to Get Your Drink On, or Sign Up to Look Bougie AF!"
        erb :index
    end

    helpers do 
        
        def logged_in?
            !!session[:user_id] 
        end

        def current_user
            logged_in? && User.find(session[:user_id])
        end

        def redirect_if_not_logged_in
            if !logged_in?
                redirect '/login'
            end
        end

        def redirect_if_logged_in
            if logged_in?
                redirect '/'
            end
        end

        def redirect_if_not_owner(menu)
            if menu_id && menu_id.user != current_user
                flash[:notice] = "Moe Szyzlak is pulling out his shotgun..."
                redirect '/products'
            end
        end

        def save_value
            # product model instead?
        end
    end

end