class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  has_many :comments, ->{ order("updated_at desc") }, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :following, ->{ order("updated_at desc") }, through: :active_relationships, source: :following
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "following_id", dependent: :destroy
  has_many :followers, ->{ order("updated_at desc") }, through: :passive_relationships, source: :follower
  has_many :storages, ->{ order("created_at desc")}

  mount_uploader :avatar, AvatarUploader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  def user_letters
    letters = []
    self.comments.each do |comment|
      letters << comment.letter
    end
    letters
  end

  def sum_like
    sum_likes = 0
    self.comments.each do |comment|
      sum_likes += comment.likes.length
    end
    sum_likes
  end

  def follow(other_user)
    active_relationships.create(following_id: other_user.id)
  end

  def unfollow(other_user)
    active_relationships.find_by(following_id: other_user.id).destroy
  end

  def with_following(other_user)
    active_relationships.find_by(following_id: other_user.id)
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def full_name
    "#{last_name} #{first_name}"
  end

  def self.select_or_create_omniauth(auth)
    find_by(auth.slice(:provider, :uid)) || self.create(
      provider: auth.provider,
      uid: auth.uid,
      email: auth.info.email,
      first_name: auth.info.name.split[0],
      last_name: auth.info.name.split[1],
      password: Devise.friendly_token[0,20]
    )
  end
end
