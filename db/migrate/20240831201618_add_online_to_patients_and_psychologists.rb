# db/migrate/XXXXXX_add_online_to_patients_and_psychologists.rb
class AddOnlineToPatientsAndPsychologists < ActiveRecord::Migration[6.1]
  def change
    add_column :patients, :online, :boolean, default: false
    add_column :psychologists, :online, :boolean, default: false
  end
end
