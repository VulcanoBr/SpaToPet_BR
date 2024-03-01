class AddColorToAppointmentType < ActiveRecord::Migration[7.1]
  def change
    add_column :appointment_types, :color, :string, default: "#000000"
  end
end
