class TweetsController < ApplicationController

  get '/tweets' do
    redirect_home
  end

  get '/tweets/new' do
    if logged_in?
      erb :"/tweets/new"
    else
      redirect '/'
    end
  end

  get '/tweets/:id' do
    redirect_home
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :"/tweets/edit"
    else
      redirect '/'
    end
  end

  patch '/tweets/:id/edit' do
    tweet = Tweet.find(params[:id])
    tweet.content = params[:content]
    tweet.save

    redirect '/home'
  end

  post '/tweets/new' do
    @tweet = Tweet.new(content: params[:content])
    current_user.tweets << @tweet
    @tweet.save

    redirect "/home"
  end

  delete '/tweets/:id' do
    tweet = Tweet.find(params[:id])
    tweet.delete

    redirect '/home'
  end

end