class UserController < ApplicationController
require 'pry'
  #signing up

  get '/users' do
    @users = User.all
    erb :'/users/index'
  end

  get '/signup' do
     erb :'users/new'
  end

  post '/users' do
    binding.pry
    @user = User.new(params)
    if @user.save
      session[:id] = @user.id
      # redirect to '/users'
    else
      erb :'/users/new'
    end


  end

#this is the login feature

  get '/login' do
    if is_logged_in?
    #  flash[:message] = "No need to do that. You're logged in."
      redirect to '/posts'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:user][:username])
  if user && user.authenticate(params[:user][:password])
    session[:id] = user.id
    redirect to '/users/#{user.id}'
  else
    flash[:message] = "Hmm. It looks like that's incorrect. Try again."
    redirect to '/login'
    end
  end

#this is the logout feature
  get '/logout' do
      # if is_logged_in?
        session.clear
        # flash[:message] = "You have been logged out of your account."
        redirect '/'
  end

end
