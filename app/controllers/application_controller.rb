class ApplicationController < Sinatra::Base
  configure do
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
    register Sinatra::Flash
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
      redirect "/users/#{user.id}"
    else
      flash[:failed_signup] = "Please fill out all input fields."
      redirect '/signup'
    end
  end

  get '/users/:user_id' do
    if logged_in?
      @user = User.find(params[:user_id])
      erb :"user/profile"
    else
      redirect '/'
    end
  end


end

def logged_in?
  if session[:id]
    true
  else
    false
  end
end
