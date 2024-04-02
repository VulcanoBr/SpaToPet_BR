class AddPetToAppointment < ActiveRecord::Migration[7.1]
  def change
    add_reference :appointments, :pet, foreign_key: true, type: :uuid
  end
end
