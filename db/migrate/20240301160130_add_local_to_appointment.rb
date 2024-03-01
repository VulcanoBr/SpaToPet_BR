class AddLocalToAppointment < ActiveRecord::Migration[7.1]
  def change
    add_reference :appointments, :local, foreign_key: true, type: :uuid
  end
end
