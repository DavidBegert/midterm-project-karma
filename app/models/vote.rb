class Vote < ActiveRecord::Base
  belongs_to :users 
  belongs_to :deeds
  validates :deed_id, uniqueness: { scope: :user_id }
end
