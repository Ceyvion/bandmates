class PostsController < ApplicationController

  # Create
  get '/posts/new' do # takes you to the create a post page
    if is_logged_in?
      erb :'posts/new'
    else
      flash[:message] = "Looks like you weren't logged in yet. Please log in below."
      redirect to '/login'
    end
  end

  post '/posts' do
    if params[:location] == "" || params[:vibe] == "" || params[:description] == "" || params[:skill_level] == "" # must have location, vibe, description, & skill level
      flash[:message] = "Oops! Posts must have a location, vibe, description and skill level. Please try again."
      redirect to '/posts/new'
    else
      user = current_user
      @post = Post.create(
        :location => params[:location],
        :description => params[:description],
        :vibe => params[:vibe],
        :skill_level => params[:skill_level],
        :user_id => user.id)
      redirect to "/posts/#{@user.user_id}"
    end
  end


  # Read
  get '/posts' do
    if is_logged_in?
      @user = current_user
      @posts = @user.posts.all
      erb :'posts/index'
    else
      flash[:message] = "Looks like you weren't logged in yet. Please log in below."
      redirect to '/login'
    end
  end

  get '/posts/:id' do
    if is_logged_in?
      @posts= Post.find_by_id(params[:id])
      if @current_user.id == session[:id]
        erb :'posts/'
      else @user.id != session[:id]
        redirect '/posts'
      end
    end
  end

  # Update
  get '/posts/:id/edit' do
    if is_logged_in?
      @post = Post.find_by_id(params[:id])
      if @post.user_id == session[:user_id]
        erb :'posts/edit'
      else
        flash[:message] = "Sorry, you can only edit your own listings."
        redirect to '/posts'
        end
      else
        flash[:message] = "Looks like you weren't logged in yet. Please log in below."
        redirect to '/login'
      end
    end
  end

  patch '/posts/:id' do
    if params[:location] == "" || params[:vibe] == "" || params[:description] == "" || params[:skill_level] == ""
      flash[:message] = "Oops! Listings must have a Location, Vibe, Description and Skill Level. Please try again."
      redirect to "/posts/#{params[:id]}/edit"
    else
      @post = Post.find_by_id(params[:id])
      @post.location = params[:location]
      @post.vibe = params[:vibe]
      @post.description = params[:description]
      @post.skill_level = params[:skill_level]
      @post.user_id = current_user.id
      @post.save
      flash[:messsage] = "Your listing has been updated!"
      redirect to "/posts/#{@user.id}"
    end
  end

  # Delete
  delete '/posts/:id/delete' do
    if is_logged_in?
      @post = Post.find_by_id(params[:id])
      if @post.user_id == session[:user_id]
        @post.delete
        flash[:message] = "Poof! Gone."
        redirect to '/posts'
      end
    else
      flash[:message] = "Looks like you weren't logged in yet. Please log in below."
      redirect to '/login'
    end
  end
