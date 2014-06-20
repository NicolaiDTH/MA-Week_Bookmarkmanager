require 'sinatra'
require 'sinatra/flash'
require_relative './server'

set :public_folder, Proc.new {File.join(root, '..', "public")}
set :views, Proc.new {File.join(root,'../views/')}

  enable :sessions
  set :session_secret, 'super secret'

helpers do
  def current_user    
    @current_user ||=User.get(session[:user_id]) if session[:user_id]
  end
end

get '/' do
  erb :visitors, layout: false
end

# get '/signon/new' do
#   erb :signon
# end

# post '/signon/new' do
#   if User.create(:email => params[:email], 
#                  :password => params[:password])
#   session[:user_id] = user.id
#   redirect to('/home')
#   else
#   redirect to('/fail') 
#   end
# end

get '/signup/new' do
  @user = User.new
  erb :signup, layout: false
end

post '/signup/new' do
  @user = User.new(:email => params[:email], 
                 :password => params[:password],
                 :password_confirmation => params[:password_confirmation])
  if @user.save
    session[:user_id] = @user.id
    flash[:notice] = ""
    redirect to '/home' 
  else
    flash[:notice] = "wrong"
    redirect to '/fail'
  end
end

get '/home' do
  erb :home
end

post '/home' do
  url = params["url"]
  title = params["title"]
  tag = params["tag"].split(" ").map do |tag|
  Tag.first_or_create(:text => tag)
  end  
  Link.create(:url => url, :title => title, :tags => tag)
  redirect to('/links')
end

get '/links' do 
  @links = Link.all
  erb :links
end

get '/links/:text' do
  tag = Tag.first(:text => params[:text])
  @links = tag ? tag.links : []
  erb :links
end

get '/delete/:id' do
  link = Link.first(:id => params[:id])
  link.destroy!
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

get '/fail' do
  erb :fail
end