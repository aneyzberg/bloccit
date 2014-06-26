class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  mount_uploader :avatar, AvatarUploader

   validates :body, length: { minimum: 5 }, presence: true
end
