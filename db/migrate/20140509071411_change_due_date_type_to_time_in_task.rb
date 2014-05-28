class ChangeDueDateTypeToTimeInTask < ActiveRecord::Migration
  def change
  	change_column:tasks,:due_date ,:time
  end
end
