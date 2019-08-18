class Auto < ApplicationRecord
  belongs_to :ad, optional: true
  belongs_to :model, optional: true

  def self.search(search)
    if search
      where('full_name LIKE ?', "%#{search}%")
    else
      all
    end
  end
end