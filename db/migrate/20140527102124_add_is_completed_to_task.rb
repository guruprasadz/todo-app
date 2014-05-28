class AddIsCompletedToTask < ActiveRecord::Migration
  def change
  	add_column :tasks, :is_completed, :string
  end
end
