class CocktailIngredient < ApplicationRecord
  belongs_to :cocktail
  belongs_to :ingredient

  def ingredient_attributes=(ingredient_attributes)
    ingredient_attributes.values.each do |attribute|
      if attribute != ""
        new_ingredient = Ingredient.find_or_create_by(name: attribute)
        self.ingredient = new_ingredient
      end
    end
  end
end
