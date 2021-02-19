class TweetsController < ApplicationController

    get "/tweets" do 
        # binding.pry
        if is_logged_in?(session)
            @user = current_user
            @tweets = Tweet.all
            erb :"tweets/index"
        else 
            redirect "/login"
        end
    end

    get "/tweets/new" do
        if is_logged_in?(session)
            erb :"tweets/new"
        end
    end
end
