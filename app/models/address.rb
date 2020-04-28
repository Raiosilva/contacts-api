class Address < ApplicationRecord
  belongs_to :notebook, optional: true
end
