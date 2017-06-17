class CocktailIngredient < ApplicationRecord
  belongs_to :cocktail, optional: true
  belongs_to :ingredient, optional: true
  validates :quantity, presence: true
  serialize :quantity

  def ingredient_attributes=(ingredient_attributes)
    ingredient_attributes.values.each do |attribute|
      if attribute != ""
        new_ingredient = Ingredient.find_or_create_by(name: attribute)
        self.ingredient = new_ingredient
      end
    end
  end
end
