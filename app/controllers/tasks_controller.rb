class TasksController < ApplicationController
    before_action :require_login

    def show
        @task = Task.find(params[:id])
    end
  
    def index
      @tasks = Task.all
    end
  
    def new
      @task = Task.new
    end
  
    def edit
      @task = Task.find(params[:id])
    end
  
    def create
      @task = Task.new(task_params)
      @task.user = current_user
      if @task.save
        @user = current_user
        redirect_to @task, notice: "Task creation is done"

      else
        render :new, status: :unprocessable_entity, alert: "Something went wrong. Please check your Internet Connection or please refresh the page and continue again"
    end
    end
  
    def update
      @task = Task.find(params[:id])
      if @task.update(task_params)
        flash[:notice] = "Task was updated successfully."
        redirect_to @task
  
      else
        render :edit, status: :unprocessable_entity
    end
  
    end
  
    def destroy
      @task = Task.find(params[:id])
      @task.destroy
      redirect_to tasks_path, notice: "Your task was successfully deleted"
    end
  
    private
  
    def task_params
      params.require(:task).permit(:title, :description, :task_start_time, :task_end_time)
    end
  
    def require_login
        unless logged_in_as_user? 
          flash[:alert] = "Please log in to continue."
          redirect_to sign_in_path
        end
    end

    
end
