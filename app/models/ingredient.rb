class Ingredient < ApplicationRecord
	has_many :cocktail_ingredients
	has_many :cocktails, through: :cocktail_ingredients
	has_many :users_ingredients
	has_many :users, through: :users_ingredients

	validates :name, presence: true
end
