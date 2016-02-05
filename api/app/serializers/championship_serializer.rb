class ChampionshipSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :seasons, embed: :ids
end
