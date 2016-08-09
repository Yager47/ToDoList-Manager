class AddAttachToComments < ActiveRecord::Migration
  def change
    add_column :comments, :attach, :string
  end
end
