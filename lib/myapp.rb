require 'sinatra'
require_relative './server'

enable :sessions

set :public_folder, Proc.new {File.join(root, '..', "public")}
set :views, Proc.new {File.join(root,'../views/')}

get '/' do
  erb :home
end

post '/' do
  url = params["url"]
  title = params["title"]
  Link.create(:url => url, :title => title)
  redirect to('/links')
end

get '/links' do 
  @links = Link.all
  erb :links
end

get '/delete/:id' do
  Link.get(params[:id]).destroy
  redirect to '/links'
end

get '/level0' do
  erb :level0
end

post '/level0' do
  if params[:password] == 'key'
    session[:password]= params[:password]
    redirect '/level1'
  else
    erb :error
  end
end

get '/level1' do
  erb :level1
end

post '/level1' do
  if params[:password] == 'life'
    session[:password]= params[:password]
    redirect '/level2'
  else
    erb :error
  end
end

get '/level2' do
  erb :level2
end

post '/level2' do
  if params[:password] == 'death'
    session[:password]= params[:password]
    redirect '/level3'
  else 
    redirect '/error'
  end
end

get '/level3' do
  erb :level3
end

post '/level3' do
  if params[:password] == 'red'
    session[:password]= params[:password]
    redirect '/level4'
  else 
    redirect '/error'
  end
end

get '/level4' do
  erb :level4
end

post '/level4' do
  if params[:password] == 'pen'   
    session[:password]= params[:password]    
    redirect '/level5'
  else 
    redirect '/error'
  end
end

get '/level5' do
  erb :level5
end

post '/level5' do
  if params[:password] == ''   
    session[:password]= params[:password]    
    redirect '/'
  else 
    redirect '/error'
  end
end

get '/error' do
  erb :error
end