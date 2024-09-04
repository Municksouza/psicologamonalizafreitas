class CreateTestimonials < ActiveRecord::Migration[6.1]
  def change
    create_table :testimonials do |t|
      t.references :patient, null: true, foreign_key: true
      t.references :psychologist, null: true, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
