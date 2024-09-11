class AddFullNameToPatients < ActiveRecord::Migration[7.2]
  def change
    add_column :patients, :full_name, :string
  end
end
