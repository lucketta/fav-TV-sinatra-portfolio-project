class ApplicationController < Sinatra::Base
  configure do
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
    register Sinatra::Flash
  end

  get '/' do
    if !logged_in?
      erb :index
    else
      redirect "/users/#{session[:id]}"
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect "/users/#{@user.id}"
    else
      flash[:failed_login] = "Invalid username or password. Try again."
      redirect '/'
    end
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

  get '/shows/new' do
    if logged_in?
      erb :"show/new"
    else
      redirect '/'
    end
  end

  post '/shows' do
    if logged_in?
      if !params[:name].empty? && !params[:network].empty? && !params[:airdate].empty? && !params[:link].empty?
        show = Show.create(params)
        show.user_id = session[:id]
        show.save
        redirect "/shows/#{show.id}"
      else
        flash[:failed_new_show] = "Please fill out all fields."
        redirect '/shows/new'
      end
    end
  end


  get '/shows/:show_id' do
    if logged_in?
      @show = Show.find(params[:show_id])
      erb :"show/show"
    else
      redirect '/'
    end
  end

  patch '/shows/:show_id' do
    if logged_in?
      @show = Show.find(params[:show_id])

      if !params[:name].empty?
        @show.name = params[:name]
      end
      if !params[:network].empty?
        @show.network = params[:network]
      end
      if !params[:airdate].empty?
        @show.airdate = params[:airdate]
      end
      if !params[:link].empty?
        @show.link = params[:link]
      end
    else
      redirect '/'
    end
    @show.save
    redirect "/shows/#{@show.id}"
  end

  get '/shows/:show_id/edit' do
    if logged_in?
      @show = Show.find(params[:show_id])
      erb :"show/edit"
    else
      redirect '/'
    end
  end


  delete '/shows/:show_id/delete' do
    if logged_in?
      show = Show.find(params[:show_id])
      if show.user_id == session[:id]
        user = show.user
        show.destroy
        redirect "/users/#{user.id}"
      else
        redirect ""
      end
    else
      redirect '/'
    end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

end #end ApplicationController

def logged_in?
  if session[:id]
    true
  else
    false
  end
end
