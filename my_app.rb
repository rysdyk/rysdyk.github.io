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
    erb :blog
  end
  
  get '/about' do
    erb :about
  end
  
  # get '/:name/:age' do
  #   @name = params[:name]
  #   @age = params[:age]
  #   erb :greeting
  # end
  
  
end

MyApp.run!
