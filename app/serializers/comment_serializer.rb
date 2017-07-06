class CommentSerializer < ActiveModel::Serializer
  attributes :comment, :id
  has_one :user
end
