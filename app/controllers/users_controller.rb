class UsersController < ApplicationController

  get '/login' do
    erb :"users/login"
  end

  post '/login' do
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect "/users/#{@user.id}"
    else
      flash[:error] = "Invalid username or password. Try again."
      redirect '/'
    end
  end

  get '/signup' do
    erb :"users/new"
  end

  post '/signup' do
    if !User.find_by(username: params[:user][:username])

      if !params[:user][:username].empty? && !params[:user][:email].empty? && !params[:user][:password].empty?
        user = User.create(params[:user])
        session[:id] = user.id
        redirect "/users/#{user.id}"
      else
        flash[:error] = "Please fill out all input fields."
        redirect '/signup'
      end
    else
      flash[:error] = "User already exists"
      redirect '/signup'
    end
  end

  get '/users/:user_id' do
    authenticate_user
    erb :"users/show"
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

end
