class Ad < ApplicationRecord
  has_one :auto
  belongs_to :place, optional: true
  belongs_to :seller, optional: true
end
