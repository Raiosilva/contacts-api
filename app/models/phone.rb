class Phone < ApplicationRecord
  belongs_to :notebook, optional: true
end
