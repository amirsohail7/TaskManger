class TasksController < ApplicationController
  before_action :set_task, only: %i[edit update destroy show]
  before_action :load_tasks, only: [:index]

  def index; end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.turbo_stream do
          render turbo_stream: turbo_stream.append(
            :tasks,
            partial: 'tasks/task',
            locals: { task: @task }
          )
        end
      else
        format.html { render :new }
      end
    end
  end

  def show; end

  def edit; end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@task, partial: "tasks/task", locals: { task: @task }) }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @task.destroy
  
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.remove(@task)
      end
    end
  end

  def toggle_status
    @task = Task.find(params[:id])
    @task.update(completed: !@task.completed)
    render json: { completed: @task.completed }
  end
  

  private

  def set_task
    @task = Task.find_by(id: params[:id])
    redirect_to tasks_path, alert: 'Task not found' unless @task
  end

  def load_tasks
    @tasks = Task.all
    @task = Task.new
  end

  def task_params
    params.require(:task).permit(:name, :description)
  end
end
