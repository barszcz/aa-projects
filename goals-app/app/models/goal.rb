class Goal < ActiveRecord::Base
  validates :aim, :user_id, presence: true
  validates :public, :completed, inclusion: { in: [true, false] }

  belongs_to :user
end
