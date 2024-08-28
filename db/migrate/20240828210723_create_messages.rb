class CreateMessages < ActiveRecord::Migration[7.2]
  def change
    create_table :messages do |t|
      t.text :content
      t.references :psychologist, null: false, foreign_key: true
      t.references :patient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
