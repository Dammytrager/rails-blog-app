class Article < ApplicationRecord
  validates :name, :description, presence: true

  belongs_to :user

  has_many :articles_categories
  has_many :categories, through: :articles_categories


  def belongs_to_user?(user)
    self.user == user
  end

end
