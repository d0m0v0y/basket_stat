class StatisticSerializer < ActiveModel::Serializer
  attributes(*Statistic.attribute_names.map(&:to_sym))
end
