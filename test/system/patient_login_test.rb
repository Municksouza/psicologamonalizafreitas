# # test/system/patient_login_test.rb
# require "application_system_test_case"

# class PatientLoginTest < ApplicationSystemTestCase
#   test "allows a patient to log in" do
#     patient = patients(:one) # Assuming you have a fixture for patients

#     visit new_patient_session_path
#     fill_in 'Email', with: patient.email
#     fill_in 'Password', with: 'password' # Use the actual password or adjust as needed
#     click_on 'Log in'

#     assert_text 'Logged in successfully'
#   end
# end
