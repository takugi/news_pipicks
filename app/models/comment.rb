class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :letter
  has_many :likes
end
