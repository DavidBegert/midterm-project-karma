class Vote < ActiveRecord::Base
  belongs_to :users 
  belongs_to :deeds
  validates :deed_id, :user_id, :value, presence: true
  validates :deed_id, uniqueness: { scope: [:user_id, :value] }
end
