class Article < ApplicationRecord
  validates :name, :description, presence: true

  belongs_to :user

  def belongs_to_user?(user)
    self.user == user
  end

end
