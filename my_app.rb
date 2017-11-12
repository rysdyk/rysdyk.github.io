require 'rubygems' if RUBY_VERSION < "1.9"
require 'sinatra'
require 'compass'
require 'sass'

class MyApp < Sinatra::Base
  
  configure do 
    set :erb, layout: :'layout'
  end
  
  get '/styles.css' do
    scss :'styles/app'
  end
  
  get '/' do
    @title = "Posts"
    erb :posts
  end
  
  # get '/posts/:slug' do
  #   @post = Post.find_by(slug: params[:slug])
  #   erb :post
  # end
  
  get '/about' do
    @title = "About"
    erb :about
  end
  
  get '/now' do
    @title = "Now"
    erb :now
  end
  
  # get '/:name/:age' do
  #   @name = params[:name]
  #   @age = params[:age]
  #   erb :greeting
  # end
  
  
end

MyApp.run!
