class CommentSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :cocktail_id, :comment
end
