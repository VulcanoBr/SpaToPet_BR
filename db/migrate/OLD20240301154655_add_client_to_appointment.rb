class AddClientToAppointment < ActiveRecord::Migration[7.1]
  def change
    add_reference :appointments, :client, null: false, foreign_key: { to_table: :users }, type: :uuid
  end
end
