class CocktailIngredientSerializer < ActiveModel::Serializer
  attributes :quantity
  has_one :ingredient
end
