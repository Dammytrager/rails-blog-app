class User < ApplicationRecord

  before_save { self.email = email.downcase }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  enum user_type: {
    normal: 0,
    admin: 1
  }, _prefix: true

  validates :username, uniqueness: true, presence: true
  validates :username, length: { minimum: 3, maximum: 50 }, unless: -> { username.blank? }

  validates :email, uniqueness: true, presence: true
  with_options if: :email_filled? do
    validates :email, length: { minimum: 3, maximum: 50 }
    validates :email, format: { with: VALID_EMAIL_REGEX }
  end

  has_many :articles, dependent: :destroy

  scope :with_no_article, lambda { where.not(id: Article.distinct.select(:user_id)) }
  scope :with_article, lambda { where(id: Article.distinct.select(:user_id)) }

  has_secure_password

  def email_filled?
    email.present?
  end

  def is?(user)
    self == user
  end

end