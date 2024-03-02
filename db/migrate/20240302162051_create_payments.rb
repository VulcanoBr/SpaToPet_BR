class CreatePayments < ActiveRecord::Migration[7.1]
  def change
    create_table :payments, id: :uuid do |t|
      t.integer :billing_status, default: 0
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :appointment, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
