class CreateAds < ActiveRecord::Migration[5.0]
  def change
    create_table :ads do |t|
      t.belongs_to :seller, foreign_key: true
      t.string  :link
      t.float   :price
      t.string  :place
      t.date    :ad_date
      t.integer :views
      t.timestamps
    end
  end
end
