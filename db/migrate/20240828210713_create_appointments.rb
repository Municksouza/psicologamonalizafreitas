class CreateAppointments < ActiveRecord::Migration[7.2]
  def change
    create_table :appointments do |t|
      t.datetime :date
      t.references :psychologist, null: false, foreign_key: true
      t.references :patient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
