class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: {case_sensitive: false }
  has_secure_password
  
  has_many :microposts
  #followしている人
  has_many :following_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :following_users, through: :following_relationships, source: :followed
  #特定のuserがfollowしている人
  has_many :follower_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :follower_users, through: :follower_relationships, source: :follower


  #画像データの関連付け
  has_one :image, class_name: "UserImage", dependent: :destroy


  # 他のユーザーをフォローする
  def follow(other_user)
    following_relationships.create(followed_id: other_user.id)
  end

  # フォローしているユーザーをアンフォローする
  def unfollow(other_user)
    following_relationships.find_by(followed_id: other_user.id).destroy
  end

  # あるユーザーをフォローしているかどうか？
  def following?(other_user)
    following_users.include?(other_user)
  end
  
  def followed_count
    follower_relationships.count
  end
  
  def following_count
    following_relationships.count
  end
   
  
  # 投稿を取得
  def feed_items
    Micropost.where(user_id: following_user_ids + [self.id])
  end
end
