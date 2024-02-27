class CreateLocals < ActiveRecord::Migration[7.1]
  def change
    create_table :locals, id: :uuid do |t|
      t.references :city, null: false, foreign_key: true, type: :uuid
      t.text :address

      t.timestamps
    end
  end
end
