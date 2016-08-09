class Comment < ActiveRecord::Base
  belongs_to :task

  validates :text, presence: true

  mount_uploader :attach, AttachUploader
end