class Ad < ApplicationRecord
  has_one :auto
  belongs_to :seller, optional: true
end
