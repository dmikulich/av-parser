class Model < ApplicationRecord
  has_many :autos
  belongs_to :brand, optional: true
end
