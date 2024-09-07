# db/seeds.rb
3.times do |i|
  patient = Patient.find_or_create_by(email: "patient#{i}@example.com") do |p|
    p.full_name = "Patient #{i}"
    p.password = 'securepassword' # Ensure this matches your validation rules
    # Set other fields as needed
  end

  psychologist = Psychologist.find_or_create_by(email: "psychologist#{i}@example.com") do |p|
    p.full_name = "Psychologist #{i}"
    p.password = 'securepassword' # Ensure this matches your validation rules
    # Set other fields as needed
  end

  Appointment.create(
    patient_id: patient.id,
    psychologist_id: psychologist.id,
    start_time: Date.today.beginning_of_month + i.days,
    end_time: Date.today.beginning_of_month + i.days + 1.hour,
    status: 'available'
  )
end
