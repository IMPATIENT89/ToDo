class SessionsController < ApplicationController
    def new
        
    end
    
    def create
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect_to user, notice: "Logged In Successfully"
        else
            flash.now[:alert] = "There was something wrong with your login details"
            render :new, status: :unprocessable_entity
        end
    end
    
    def destroy
        session[:user_id] = nil
        redirect_to root_path, notice: "Logged Out"
    end
    
end
