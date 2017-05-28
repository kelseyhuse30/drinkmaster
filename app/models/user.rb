class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :users_ingredients
  has_many :ingredients, through: :users_ingredients
  has_many :cocktails

  def self.find_or_create_by_omniauth(auth_hash)
		self.where(:uid => auth_hash["uid"]).first_or_create do |user|
			user.uid = auth_hash["uid"]
			user.email = auth_hash["info"]["email"]
		end
	end

end
