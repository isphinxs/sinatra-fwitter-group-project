class TweetsController < ApplicationController
    get "/tweets" do 
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
        else
            redirect "/login"
        end
    end

    post "/tweets" do
        content = params[:content]
        user_id = current_user.id
        if content.blank?
            redirect "/tweets/new"
        else
            tweet = Tweet.new(content: content, user_id: user_id)
            if tweet.save
                id = tweet.id
                redirect "/tweets/#{id}"
            end
        end
    end

    get "/tweets/:id/edit" do
        if is_logged_in?(session)
            @id = params[:id]
            @tweet = Tweet.find(@id)
            if @tweet.user_id == current_user.id
                erb :"tweets/edit"
            else
                redirect "/tweets"
            end
        else
            redirect "/login"
        end
    end

    post "/tweets/:id" do
        id = params[:id]
        tweet = Tweet.find(id)
        content = params[:content]
        if content.blank?
            redirect "/tweets/#{id}/edit"
        else
            tweet.content = content
            tweet.save
            redirect "/tweets/#{id}"
        end
    end

    get "/tweets/:id" do
        if is_logged_in?(session)
            @id = params[:id]
            @tweet = Tweet.find(@id)
            erb :"/tweets/show"
        else
            redirect "/login"
        end
    end

    delete "/tweets/:id/delete" do
        if is_logged_in?(session)
            id = params[:id]
            tweet = Tweet.find(id)
            if tweet.user_id == current_user.id
                Tweet.destroy(id)
                redirect "/tweets"
            else
                redirect "/tweets/#{id}"
            end
        else
            redirect "/login"
        end
    end
end
