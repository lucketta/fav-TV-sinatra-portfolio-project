class ApplicationController < Sinatra::Base
  configure do
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
    register Sinatra::Flash
  end

  get '/' do
    authenticate_user
    redirect "/users/#{current_user.id}"
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:id]) if session[:id]
    end

    def authenticate_user
      if !logged_in?
        redirect "/login"
      end
    end
  end

end
