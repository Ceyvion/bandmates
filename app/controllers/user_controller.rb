class UserController < ApplicationController

  #signing up

  get '/signup' do
  if is_logged_in?
    flash[:message] = "No need to do that. You're logged in."
    redirect to '/posts'
  else
    erb :'user_things/new_user'
  end
end

  post '/signup' do
    if is_logged_in?
      flash[:message] = "No need to do that. You're logged in."
      redirect to '/posts'
    elsif params[:email] == "" || params[:password_digest] == ""
      flash[:message] = "To sign up, you need an email AND password. Try again."
      redirect to '/signup'
    else
      @user = User.create({email: params[:username], password_digest: params[:password_digest] })
      @user.save
      session[:@user.id]
      redirect to '/posts'
    end

    

  end


end
end
