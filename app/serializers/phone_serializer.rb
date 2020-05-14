class PhoneSerializer < ActiveModel::Serializer
  attributes :id, :number

  belongs_to :notebook
end
