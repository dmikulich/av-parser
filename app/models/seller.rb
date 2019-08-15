class Seller < ApplicationRecord
  has_many :ads #, dependent: destroy
end
