class UsersController < ApplicationController
    get "/users/:slug" do
        @user = User.find_by_slug(params[:slug])
        @tweets = @user.tweets.all
        erb :"users/show"
    end
end
