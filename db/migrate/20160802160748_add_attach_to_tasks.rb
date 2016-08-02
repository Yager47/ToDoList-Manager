class AddAttachToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :attach, :string
  end
end
