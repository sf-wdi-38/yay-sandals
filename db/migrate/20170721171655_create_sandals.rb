class CreateSandals < ActiveRecord::Migration[5.1]
  def change
    create_table :sandals do |t|
      t.string :title
      t.integer :price

      t.timestamps
    end
  end
end
