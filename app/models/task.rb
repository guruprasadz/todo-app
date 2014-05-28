class Task < ActiveRecord::Base
	validates_presence_of :title 
	validate :future_completed_date
	validate :validate_due_date
	belongs_to :user 
	validates_presence_of :user

	def self.cron_job
		tasks=Task.where(:completed_at => nil).all
		tasks.each do |t|
			if t.due_date < Date.today 
				TaskMailer.due_date_passed_mail(t.user,t).deliver
			end
		end
	end

	private 
	def future_completed_date
		if !completed_at.blank? && completed_at > Date.today
			self.errors.add(:completed_at, "Please enter valid date") 
		end
	end
	def validate_due_date
		if !due_date.blank? &&  due_date < Date.today
			self.errors.add(:due_date, "Please enter valid date") 
		end
	end
end
