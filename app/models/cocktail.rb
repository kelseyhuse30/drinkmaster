class Cocktail < ApplicationRecord
	has_many :cocktails_ingredients
	has_many :ingredients, through: :cocktails_ingredients
end
