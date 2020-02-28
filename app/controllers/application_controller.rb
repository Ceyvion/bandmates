require './config/environment'
require 'sinatra-flash'

class ApplicationController < Sinatra::Base

#this is to enable sessions
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'band_man_jam_man'
    register Sinatra::Flash
  end

#this is the default page/homescreen
  get "/" do
    erb :index
  end

  def is_logged_in?
    !!session[:id]
  end

  def current_user
  @user = User.find(session[:id])
end


end
