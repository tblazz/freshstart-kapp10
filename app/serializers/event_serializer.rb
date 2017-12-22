class EventSerializer < ActiveModel::Serializer

  attributes :name, :place, :website, :facebook, :twitter, :instagram, :contact, :email, :phone, :created_at, :updated_at

end
