class UsersController < ApplicationController

    get "/users/:id" do
        if is_logged_in?(session)
            @user = User.find(params[:id])
            
        end
    end

end
