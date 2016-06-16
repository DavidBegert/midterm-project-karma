class Deed < ActiveRecord::Base
  belongs_to :user
  has_many :votes
  validates :summary, presence: true, length: { minimum: 1 }


end