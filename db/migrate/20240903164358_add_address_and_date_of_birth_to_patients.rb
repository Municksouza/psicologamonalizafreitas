class AddAddressAndDateOfBirthToPatients < ActiveRecord::Migration[7.2]
  def change
    add_column :patients, :address, :string unless column_exists?(:patients, :address)
    add_column :patients, :date_of_birth, :date unless column_exists?(:patients, :date_of_birth)
  end
end
