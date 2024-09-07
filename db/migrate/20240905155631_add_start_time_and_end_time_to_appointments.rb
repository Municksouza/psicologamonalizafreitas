class AddStartTimeAndEndTimeToAppointments < ActiveRecord::Migration[7.2]
  def change
    add_column :appointments, :start_time, :datetime
    add_column :appointments, :end_time, :datetime
  end
end
