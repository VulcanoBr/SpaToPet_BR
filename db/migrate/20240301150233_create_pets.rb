class CreatePets < ActiveRecord::Migration[7.1]
  def change
    create_table :pets, id: :uuid do |t|
      t.string :name, null: false
      t.string :breed, null: false
      t.integer :kind, null: false
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
