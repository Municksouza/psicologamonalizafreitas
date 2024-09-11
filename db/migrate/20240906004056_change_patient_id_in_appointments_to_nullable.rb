class ChangePatientIdInAppointmentsToNullable < ActiveRecord::Migration[7.2]
  def change
    change_column_null :appointments, :patient_id, true
  end
end
