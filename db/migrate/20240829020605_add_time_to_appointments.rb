class AddTimeToAppointments < ActiveRecord::Migration[7.2]
  def change
    add_column :appointments, :time, :time
  end
end
