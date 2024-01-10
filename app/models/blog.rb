class Blog < ApplicationRecord
    belongs_to :user
    has_many :comments, dependent: :destroy
    has_many :blog_categories, dependent: :destroy
    has_many :categories, through: :blog_categories

end
