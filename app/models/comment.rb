class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :letter
  has_many :likes, dependent: :destroy

  def user_like(user)
    self.likes.find_by(user_id: user.id)
  end
end
