class CreateAppointmentTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :appointment_types, id: :uuid do |t|
      t.string :name, null: false
      t.boolean :payment_required, null: false
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.integer :price, null: false

      t.timestamps
    end
  end
end
