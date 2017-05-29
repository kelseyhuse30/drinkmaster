module CocktailsHelper

	def alcoholic?(cocktail)
		cocktail.alcoholic ? "Alcoholic Beverage" : "Non-alcoholic"
	end
end
