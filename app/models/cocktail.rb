class Cocktail < ApplicationRecord
	has_many :cocktail_ingredients
	has_many :ingredients, through: :cocktail_ingredients
	belongs_to :user
	validates :name, presence: true
	accepts_nested_attributes_for :cocktail_ingredients, :reject_if => proc { |attr| attr[:quantity].blank? && attr[:ingredient_attributes][:name].blank? }

	def self.mocktails
		Cocktail.where(alcoholic: false)
	end

	def self.order_by_ingredients
		Cocktail.all.sort { |a, b| b.ingredients.count <=> a.ingredients.count }
	end

end
