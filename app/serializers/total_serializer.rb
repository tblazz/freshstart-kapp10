class PhotoSerializer < ActiveModel::Serializer

  attributes :points, :date, :created_at, :updated_at
  has_one :runner
end
