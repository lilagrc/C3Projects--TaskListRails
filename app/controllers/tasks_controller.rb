class TasksController < ApplicationController


  def index
    @tasks = Task.all
    @people = Person.all
  end

  def show
    @task = Task.find(params[:id])
    @task_name = @task.name
    @task_description = @task.description

    #checks if task is completed, and that date is past
    @completed = false
    @future_date = false
    if @task.completed_date
      @completed_date = @task.completed_date
      @completed_date = @completed_date.strftime("%m/%d/%Y")
      @future_date = true
      if @task.completed_date && @task.completed_date < Time.now
        @completed = true
        @future_date = false
      end
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(create_params[:task]) #how to check for nil values?
    @task.save

    redirect_to "/"
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    @task.save #this might not be necessary

    redirect_to "/"
  end

  def complete
    @task = Task.find(params[:id])
    @task[:completed_date] = Time.now
    @task.save

    redirect_to "/"
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    @task.update(create_params[:task])

    redirect_to "/"
  end


  private

  def create_params
    params.permit(task: [:id, :name, :description, :completed_date, :person_id])
  end

end
