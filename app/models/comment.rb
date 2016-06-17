class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :deed

  validates :content, presence: true

end