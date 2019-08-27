class Auto < ApplicationRecord
  belongs_to :ad, optional: true
  belongs_to :model, optional: true

  def self.search(search)
    if search
      where('lower(full_name) LIKE ?', ("%#{search.downcase}%"))
    else
      all
    end
  end
end