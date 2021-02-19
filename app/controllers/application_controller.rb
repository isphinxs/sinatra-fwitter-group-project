require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do 
    erb :index
  end

  get "/signup" do
    if is_logged_in?(session)
      redirect "/tweets"
    else
      erb :signup
    end
  end

  post "/signup" do
    username = params[:username]
    email = params[:email]
    password = params[:password]
    if is_logged_in?(session)
      redirect "/tweets"
    elsif !username.blank? && !email.blank? && !password.blank?
      user = User.new(:username => username, :email => email, :password => password)
      if user.save
        session[:user_id] = user.id
        redirect "/tweets"
        # need to add a failure
      end
    else
      redirect "/signup"
    end
  end

  get "/login" do
    if is_logged_in?(session)
      redirect "/tweets"
    else
      erb :login
    end
  end

  post "/login" do
    user = User.find_by(:username => params[:username])
    if is_logged_in?(session)
      redirect "/tweets"
    elsif user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"
    end
  end

  get "/logout" do
    if is_logged_in?(session)
      session.clear
      redirect "/login"
    else
      redirect "/index"
    end
  end

 

  helpers do
    def is_logged_in?(session)
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end
end
