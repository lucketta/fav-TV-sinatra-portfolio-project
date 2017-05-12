class ApplicationController < Sinatra::Base
  configure do
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  post '/login' do
    binding.pry
  end

  get '/signup' do
    erb :"user/create_user"
  end

  post '/signup' do
    if !params[:user][:username].empty? && !params[:user][:email].empty? && !params[:user][:password].empty?
      user = User.create(params[:user])
      session[:id] = user.id
    end
    redirect '/'
  end
end
