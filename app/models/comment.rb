class Comment < ActiveRecord::Base
  # attr_accessible :attach

  belongs_to :task
  validates :text, presence: true
  
  mount_uploader :attach, AttachUploader
end