class UsersController < ApplicationController

  get '/signup' do
    erb :"/users/signup"
  end

  post '/signup' do
    @user = User.new(
      username: params[:username],
      password: params[:psw],
      email: params[:email]
    )

    if @user.save
      session[:user_id] = @user.id
      redirect '/account'
    else
      @errors = @user.errors.full_messages
      erb :error
    end
  end

  get '/account' do
    if logged_in?
      @user = current_user
      erb :"/users/account"
    else
      redirect '/'
    end
  end

  get '/users/:slug' do
    if logged_in?
      if current_user.slug == params[:slug]
        redirect '/account'
      end
      
      @user = User.find_by_slug(params[:slug])

      erb :"/users/show"
    else
      redirect '/'
    end
  end

  post '/login' do    
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:psw])
      session[:user_id] = user.id
      session[:admin] = true if user.username == 'admin'
      redirect '/home'
    else
      erb :"/users/login_error"
    end 
  end

  get '/logout' do
    log_out!
    redirect '/'
  end

end