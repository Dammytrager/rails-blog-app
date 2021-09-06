class Article < ApplicationRecord
  validates :name, :description, presence: true
end
