class CreateAutos < ActiveRecord::Migration[5.0]
  def change
    create_table :autos do |t|
      t.belongs_to :ad, foreign_key: true
      t.string  :full_name
      t.string  :brand
      t.index   :brand
      t.string  :model
      t.integer :year
      t.string :mileage
      t.timestamps
    end
  end
end
