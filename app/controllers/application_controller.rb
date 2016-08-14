require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index 
  end

  get '/posts' do
    @posts = Post.all
    erb :posts
  end

  get '/posts/:id' do
    if params[:id].include?("new")
      erb :new_post
    elsif Post.exists?(params[:id]) == false
      erb 'sorry there, bud<br>why not <a href="/recipes/new">create a new post?</a>'
    else
      @post = Post.find(params[:id])
      erb :post
    end
  end

  get '/posts/new' do
    erb :'/new_post'
  end

  post '/create_post' do
    Post.create(name: params[:name], content: params[:content])
    redirect("/posts")
  end

  get '/posts/:id/edit' do
    @post = Post.find(params[:id])
    erb :edit_post
  end

  patch '/posts/:id/edit' do
    @post = Post.find(params[:id])
    @post.update(name: params[:name], content: params[:content])
    redirect("/posts/#{@post.id}")
  end

  get '/posts/:id/delete' do
    @post = Post.find(params[:id])
    erb :delete_post
  end

  delete '/posts/:id/edit' do
    @post = Post.find(params[:id])
    @post.destroy
    erb "#{@post.name} was deleted"
  end
end