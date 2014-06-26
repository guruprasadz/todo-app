class TaskMailer < ActionMailer::Base
  default from: "info@localhost"

  def new_task_mail(user,task)
  	@user=user
  	@task=task
  	mail(to:@user.email,subject:@task.title)
  end
  def due_date_passed_mail(user,task)
  	@user=user
  	@task=task
  	mail(to:@user.email,subject:"Due date passed")
  end 

  def todays_due_task_mail(user,task)
  	@user=user
  	@task=task
  	mail(to:@user.email,subject:"Today's Due Task")
  end
  
end
