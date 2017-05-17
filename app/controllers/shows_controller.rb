class ShowsController < ApplicationController

  get '/shows/new' do
    authenticate_user
    erb :"shows/new"
  end

  post '/shows' do
    authenticate_user
    if !params[:name].empty? && !params[:network].empty? && !params[:airdate].empty? && !params[:link].empty?
      @current_show = current_user.shows.create(params)
      redirect "/shows/#{current_show.id}"
    else
      flash[:error] = "Please fill out all fields."
      redirect '/shows/new'
    end
  end

  get '/shows/:show_id' do
    authenticate_user
    get_current_show
    erb :"shows/show"
  end

  patch '/shows/:show_id' do
    authenticate_user
    get_current_show

    if !params[:name].empty?
      @current_show.name = params[:name]
    end
    if !params[:network].empty?
      @current_show.network = params[:network]
    end
    if !params[:airdate].empty?
      @current_show.airdate = params[:airdate]
    end
    if !params[:link].empty?
      @current_show.link = params[:link]
    end

    @current_show.save
    redirect "/shows/#{@show.id}"
  end

  get '/shows/:show_id/edit' do
    authenticate_user
    get_current_show
    erb :"show/edit"
  end

  delete '/shows/:show_id/delete' do
    authenticate_user
    get_current_show
    if @current_show.user_id == session[:id]
      temp_user_id = @current_show.user_id
      @current_show.destroy
      redirect "/users/#{temp_user_id}"
    end
  end

  helpers do
    def get_current_show
      @current_show ||= Show.find_by(id: params[:show_id])
    end
  end
end
