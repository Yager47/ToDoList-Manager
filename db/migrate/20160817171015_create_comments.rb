class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :text
      t.string :attach
      t.integer :task_id
    end
  end
end
