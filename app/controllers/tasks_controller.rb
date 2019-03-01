class TasksController < ApplicationController
  before_action :set_list
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = @list.tasks.all_tasks(@list.id)
  end

  def show
  end

  def new
    @task = @list.tasks.new
  end

  def create
    @list.tasks.create_task(task_params, @list.id)
    redirect_to list_tasks_path(@list)
  end

  def edit
  end

  def update
    @list.tasks.update_task(task_params, @task.id)
    redirect_to list_tasks_path(@list)
  end

  def destroy
    @list.tasks.delete_task(@task.id)
    redirect_to list_tasks_path(@list)
  end

  private
    def set_list
      @list = List.find(params[:list_id])
    end

    def set_task
      @task = Task.single_task(@list.id, params[:id])
    end

    def task_params
      params.require(:task).permit(:title, :description)
    end
end
