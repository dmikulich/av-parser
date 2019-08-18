class CreateModels < ActiveRecord::Migration[5.0]
  def change
    create_table :models do |t|
      t.integer :brand_id
      t.string :model
      t.timestamps
    end
  end
end
