class TasksController < ApplicationController
  before_action :set_task, only: %i[edit update destroy show]
  before_action :load_tasks, only: [:index]

  def index; end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path(@task), notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: 'Task was successfully destroyed.'
  end

  private

  def set_task
    @task = Task.find_by(id: params[:id])
    redirect_to tasks_path, alert: 'Task not found' unless @task
  end

  def load_tasks
    @tasks = Task.all
  end

  def task_params
    params.require(:task).permit(:name, :description)
  end
end
