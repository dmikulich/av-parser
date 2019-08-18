class CreateAutos < ActiveRecord::Migration[5.0]
  def change
    create_table :autos do |t|
      t.belongs_to :ad, foreign_key: true
      t.integer :model_id
      t.string  :full_name
      t.index :full_name
      t.integer :year
      t.string :mileage
      t.timestamps
    end
  end
end
