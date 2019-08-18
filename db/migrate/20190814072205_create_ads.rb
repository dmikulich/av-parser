class CreateAds < ActiveRecord::Migration[5.0]
  def change
    create_table :ads do |t|
      t.integer :seller_id
      t.integer :place_id
      t.string  :link
      t.float   :price
      t.date    :ad_date
      t.integer :views
      t.timestamps
    end
  end
end
