require './config/environment'
require 'sinatra'
require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/respond_with'
# require 'sinatra/partial'

class ApplicationController < Sinatra::Base
    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
        enable :sessions
        set :session_secret, ENV["SESSION_SECRET"]
        register Sinatra::Flash
        register Sinatra::RespondWith
        # register Sinatra::Partial
        # set :partial_template_engine, :erb
        # enable :partial_underscores
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

        def redirect_if_not_owner(current_class)
            if current_class.user != current_user
                redirect '/products'
            end
        end

    end

end