class AddDescriptionToSandals < ActiveRecord::Migration[5.1]
  def change
    add_column :sandals, :description, :string
  end
end
