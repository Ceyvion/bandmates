require './config/environment'

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
    erb :'welcome'
  end

  get '/logout' do
    if is_logged_in?
      session.clear
        # flash[:message] = "You have been logged out of your account."
        redirect '/'
      end
    end

  helpers do
  def is_logged_in?
    !!current_user
  end


  def current_user
  @current_user = User.find_by_id(session[:id])
  end
end



end
