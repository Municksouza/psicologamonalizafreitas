class PatientsController < ApplicationController
  before_action :set_patient, except: [:destroy, :sign_out, :edit, :show, :update]
  before_action :authenticate_patient!, only: [:profile]

  def profile
    @patient = current_patient
    @appointments = @patient.appointments
    @appointment = Appointment.new
  end

  def show
    @appointments = @patient.appointments
  end

  def edit
    # Editing patient profile
  end

  def update
    if @patient.update(patient_params)
      redirect_to @patient, notice: 'Patient profile was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @patient.destroy
    redirect_to root_path, notice: 'Patient profile was successfully deleted.'
  end

  def sign_out
    # Logic for sign out, if needed
  end

  private

  def set_patient
    @patient = current_patient
    if params[:id].present? && params[:id] != 'sign_out'
      @patient = Patient.find(params[:id])
    else
      redirect_to root_path, alert: 'Invalid patient ID.'
    end
  end

  def patient_params
    params.require(:patient).permit(:name, :address, :date_of_birth, :email, :photo, :phone_number, :other_attributes)
  end
end
