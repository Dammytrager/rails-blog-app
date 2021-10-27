class Category < ApplicationRecord

  validates :name, presence: true

  has_many :articles_categories
  has_many :articles, through: :articles_categories

end
