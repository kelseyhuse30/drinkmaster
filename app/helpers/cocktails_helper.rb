module CocktailsHelper

	def alcoholic?(cocktail)
		cocktail.alcolic ? "Alcoholic Beverage" : "Non-alcoholic"
	end
end
