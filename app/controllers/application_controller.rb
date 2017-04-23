require './config/environment'

class ApplicationController < Sinatra::Base

  ########### BEGIN CONTROLLER CONFIG ###########

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fwitter_ftw"
  end

  ########### END CONTROLLER CONFIG ###########

  get '/' do
    if logged_in?
      redirect '/home'
    else
      erb :index
    end
  end

  get '/home' do
    @tweets = Tweet.all
    
    erb :home
  end

  get '/error' do
    erb :error
    sleep 3
    redirect '/'
  end

  ########### HELPERS BELOW ###########

  helpers do

    def logged_in?
      !!session[:user_id]
    end

    def admin?
      session[:admin] == true
    end

    def current_user
      User.find(session[:user_id])
    end

    def redirect_home
      if logged_in?
        redirect '/home'
      else
        redirect '/'
      end
    end

    def log_in
      # still need it?...
    end

    def log_out!
      session.clear
    end

  end

end