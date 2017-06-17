class CocktailSerializer < ActiveModel::Serializer
  attributes :id, :name, :instructions, :alcoholic
  has_many :cocktail_ingredients
	has_one :user
	has_many :comments
end
