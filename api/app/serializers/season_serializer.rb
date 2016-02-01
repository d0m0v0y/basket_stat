class SeasonSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :teams, embed: :ids
end
