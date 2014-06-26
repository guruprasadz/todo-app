class TasksController < ApplicationController  #Task controller to manage tasks
	#create empty task and show task form
	def new
		@task = Task.new
		render :show_form
	end

	#Create task from task form and and persist in db
	def create
		format_task_attributes(task_params)
		@task =Task.new(@updated_params)
		logger.debug "Created Task  #{@task}"
		@task.user = current_user
		authorize! :create, @task
		@task.is_completed=false
		save_task
	end

	#delete the task specified by id parameter
	def destroy
	  @task = Task.find(params[:id]) 
	  @task.destroy 
	  @tasks = Task.accessible_by(current_ability) 
	end 

	#Show task edit form for specified parameter 
	def edit
	  @task = Task.find(params[:id])
	  authorize! :edit, @task
	  render :show_form
	end

	#Update task  specified by id parameter
	def update 
	  logger.debug "Params --------------------------------------- #{params}"

	  logger.debug "task params --------------------------------------#{task_params}"
	  format_task_attributes(task_params)
	  
	  logger.debug "-------------------------------------------------------------"
	  logger.debug "Updated Params  #{@updated_params}"
	  @updated_params[:id]=params[:id]
	  @task = Task.find(@updated_params[:id])
	  logger.debug "#########################"
	  logger.debug "Task found "
	  
	  @task.assign_attributes(@updated_params)
	  authorize! :update, @task
	  @task.is_completed=false
	  save_task
	end

	def completed

		@task = Task.find(params[:id])
		if  @task.is_completed.nil? && !@task.is_completed
			authorize! :edit, @task
			@task.is_completed=true
			@task.completed_at=Date.today
			@task.due_date=DateTime.now
			
		end
			save_task
	end

	private 
	def task_params
		params.require(:task).permit(:title, :description, :completed_at,:due_date,:priority,:id)
	end
	 def save_task 	
	 	logger.debug "Inside save_task"
	 	logger.debug "Completed at #{@task.completed_at}"
	 	if @task.save 
	 		#TaskMailer.new_task_mail(@task.user,@task).deliver
			@tasks = Task.accessible_by(current_ability)
	 		render :create 
	 	else 
	 		render :show_form
	 	end 
	 end
	 #format due date parameter and generate updated parameters to crete task object 
	 def format_task_attributes(task_params)
	 	logger.debug "Inside format task attributes"
		dueDateTime=task_params['due_date'].split(" ")
		logger.debug "due dateAndTime   #{dueDateTime}"
	 	dueDate=dueDateTime.first.split("/")
	 	dueTimes=dueDateTime.last
	 	dueTime=dueDateTime[1].split(":")
	 	 if dueTimes == "PM" && dueTime[0].to_i<12
	 	 	dueTime[0]=dueTime[0].to_i+12
	 	 end
	 	dateAndTime=DateTime.new(dueDate[2].to_i ,  dueDate[0].to_i, dueDate[1].to_i, dueTime[0].to_i, dueTime[1].to_i )
		task_params.store('due_date' ,dateAndTime.to_datetime)
		logger.debug "After change #{task_params[:due_date]}"
		@updated_params=task_params
		@updated_params[:due_date]=dateAndTime.to_datetime
		logger.debug "New Hash #{@updated_params}"
	 end

end
