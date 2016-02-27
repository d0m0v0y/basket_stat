class SeasonSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :name, :link

  has_many :teams

  def link
    api_v1_championship_season_url(
      :id => object.id,
      :championship_id => object.championship_id
    )
  end

end
