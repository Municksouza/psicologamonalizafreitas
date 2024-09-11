class AddFullNameToPsychologists < ActiveRecord::Migration[7.2]
  def change
    add_column :psychologists, :full_name, :string
  end
end
