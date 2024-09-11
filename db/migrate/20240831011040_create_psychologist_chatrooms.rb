class CreatePsychologistChatrooms < ActiveRecord::Migration[7.0]
  def change
    create_table :psychologist_chatrooms do |t|
      t.bigint :psychologist_id, null: false
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false

      t.index [:psychologist_id], name: "index_psychologist_chatrooms_on_psychologist_id"
    end
  end
end
