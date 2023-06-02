class UsersController < ApplicationController
    before_action :require_admin, only: [:index, :destroy]
    def new
        @user = User.new
    end

    def show
        @user = User.find(params[:id])
        @tasks = @user.tasks
    end
    
    def index
        @users = User.paginate(page: params[:page], per_page: 10)
    end
    
    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to root_path, notice: "Successfully created account. Now, plase login with your credentials"
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            redirect_to user, notice: "Your account information was successfully updated"
        else
            render :edit, status: :unprocessable_entity
        end       
    end

    def destroy
        @user = User.find(params[:id])
        @user.destroy
        session[:user_id] = nil if @user == current_user
        flash[:notice] = "Account and all associated tasks are successfully deleted"
        redirect_to tasks_path
    end

    private

    def user_params
        params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end

    def require_admin
        unless current_user.admin?
          flash[:alert] = "This page can be only viewed by admin. Login as admin credentials to continue"
          redirect_to sign_in_path
        end
      end

    

end
