class UserController < ApplicationController
require 'pry'
  #signup

  get '/signup' do
     erb :'/users/new'
  end

  post '/signup' do
     @user = User.new(username: params[:username], password: params[:password])
    if @user.save
      session[:id] = @user.id
      redirect to '/posts/index'
    else
      #error message
      erb :'/users/new'
    end
  end

  #login

  get '/login' do
    if is_logged_in?
    #  flash[:message] = "No need to do that. You're logged in."
      redirect to '/posts'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
  if @user && @user.authenticate(params[:password])
    session[:id] = @user.id
    redirect to "/users/#{@user.id}"
  else
    flash[:message] = "Hmm. It looks like that's incorrect. Try again."
    redirect to '/login'
    end
  end

#view users
  get '/users/:id' do
   if is_logged_in?
     @user = User.find_by_id(params[:id])
     if @user.id == session[:id]
       erb :'users/index'
     elsif @user.id != session[:id]
       redirect '/users'
     end
   else
     flash[:message] = "Looks like you weren't logged in yet. Please log in below."
     redirect to '/login'
   end
  end

  post '/users' do
    # binding.pry
    @user = User.new(params)
    if @user.save
      session[:id] = @user.id
      # redirect to '/users'
    else
      erb :'/users/new'
    end
  end


  get '/users' do
    if is_logged_in?
    # binding.pry
    @user = User.all
    erb :'/users/index'
  end


#this is the logout feature
  get '/logout' do
      if is_logged_in?
        sessions.clear
        # flash[:message] = "You have been logged out of your account."
        redirect '/'
      end
    end
  end
end
