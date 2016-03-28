class StatisticSerializer < ActiveModel::Serializer
  attributes(*Statistic.attribute_names.map(&:to_sym))

  has_many :players
end
