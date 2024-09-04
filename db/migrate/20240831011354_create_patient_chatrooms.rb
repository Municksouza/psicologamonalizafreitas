class CreatePatientChatrooms < ActiveRecord::Migration[7.0]
  def change
    create_table :patient_chatrooms do |t|
      t.bigint :patient_id, null: false
      t.bigint :psychologist_id, null: false
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false

      t.index [:patient_id], name: "index_patient_chatrooms_on_patient_id"
      t.index [:psychologist_id], name: "index_patient_chatrooms_on_psychologist_id"
    end
  end
end
