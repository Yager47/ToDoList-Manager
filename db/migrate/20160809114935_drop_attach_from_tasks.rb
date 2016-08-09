class DropAttachFromTasks < ActiveRecord::Migration
  def change
    remove_column :tasks, :attach
  end
end
