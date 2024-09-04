class AddPhoneNumberToPatients < ActiveRecord::Migration[7.2]
  def change
    add_column :patients, :phone_number, :string
  end
end
