class AddPhoneNumberToPsychologists < ActiveRecord::Migration[7.2]
  def change
    add_column :psychologists, :phone_number, :string
  end
end
